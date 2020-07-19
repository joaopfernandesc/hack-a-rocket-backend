class Appointment < ApplicationRecord
    acts_as_paranoid
    before_create :set_send_timestamp
    after_create :send_scheduled_messages
    after_destroy :send_cancel_message

    def json_object
        mentor = User.find(mentor_id).json_object
        responsible = User.find(responsible_id).json_object
        path = Path.find(path_id).json_object

        return {
            id: self.id,
            start_timestamp: self.start_timestamp,
            end_timestamp: self.end_timestamp,
            mentor: mentor,
            responsible: responsible,
            path: path,
            canceled_id: self.canceled_id
        }
    end
    
    def set_send_timestamp
        self.send_timestamp = self.start_timestamp - 3600
    end

    def send_scheduled_messages
        Time.zone = "America/Sao_Paulo"
        
        mentor = User.find(self.mentor_id)
        responsible = User.find(self.responsible_id)
        path = Path.find(self.path_id)

        execute_scheduled_message(mentor, responsible, path)
        execute_scheduled_message(responsible, mentor, path)
    end

    def execute_scheduled_message(sender, recipient, path)
        formatted_time = Time.zone.at(self.start_timestamp).strftime("%d/%m/%Y às %H:%Mhs")
        content = "Olá, #{recipient.first_name}!\n\nVocê tem uma nova consultoria de *#{path.name}* agendada com #{sender.get_full_name} no dia #{formatted_time}."

        HTTP.headers("X-API-TOKEN".to_sym => ENV["ZENVIA_TOKEN"]).post("https://api.zenvia.com/v1/channels/whatsapp/messages", :json => {
			from: ENV["ZENVIA_NAME"],
			to: "55" + recipient[:phone_number],
			contents: [
				{
					type: "text",
					text: content
				}
			]
		})
    end    
    
    def send_cancel_message
        if self.canceled_id == self.responsible_id
            user_to_warn = User.find(self.mentor_id)
        else
            user_to_warn = User.find(self.responsible_id)
        end
        canceling_user = User.find(self.canceled_id)
        path = Path.find(self.path_id)
        Time.zone = "America/Sao_Paulo"
        formatted_time = Time.zone.at(self.start_timestamp).strftime("%d/%m/%Y às %H:%Mhs")
        content = "Olá, a consultoria de *#{path.name}* que você tinha agendado na data #{formatted_time} foi cancelada pela #{canceling_user.get_full_name}."
        phone_number = user_to_warn[:phone_number]
        cancel_responsible = User.find(self.canceled_id)
        phone_number = "55" + cancel_responsible[:phone_number]

        HTTP.headers("X-API-TOKEN".to_sym => ENV["ZENVIA_TOKEN"]).post("https://api.zenvia.com/v1/channels/whatsapp/messages", :json => {
			from: ENV["ZENVIA_NAME"],
			to: phone_number,
			contents: [
				{
					type: "text",
					text: content
				}
			]
		})
    end

end
