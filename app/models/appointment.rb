class Appointment < ApplicationRecord
    acts_as_paranoid
    before_create :set_send_timestamp
    after_create :send_scheduled_messages
    after_destroy :send_cancel_message

    def set_send_timestamp
        self.send_timestamp = self.start_timestamp - 3600
    end

    def send_scheduled_messages
        Time.zone = "America/Sao_Paulo"
        
        mentor = User.find(self.mentor_id)
        responsible = User.find(self.responsible_id)

        execute_scheduled_message(mentor, responsible)
        execute_scheduled_message(responsible, mentor)
    end

    def execute_scheduled_message(sender, recipient)
        formatted_time = Time.zone.at(self.start_timestamp).strftime("%d/%m/% às %H:%Mhs")
        content = "Olá!\nVocê tem uma nova consultoria agendada com #{sender.get_full_name} na data #{formatted_time}."

        HTTP.headers("X-API-TOKEN".to_sym => ENV["ZENVIA_TOKEN"]).post("https://api.zenvia.com/v1/channels/whatsapp/messages", :json => {
			from: ENV["ZENVIA_NAME"],
			to: recipient[:phone_number],
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
        Time.zone = "America/Sao_Paulo"
        formatted_time = Time.zone.at(self.start_timestamp).strftime("%d/%m/% às %H:%Mhs")
        content = "Olá, a consultoria que você tinha agendado na data #{formatted_time} foi cancelada pela outra parte."
        phone_number = user_to_warn[:phone_number]
        cancel_responsible = User.find(self.canceled_id)
        phone_number = cancel_responsible[:phone_number]

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
