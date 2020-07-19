class User < ApplicationRecord
    enum user_type: { "Empresa": 0, "Estudante": 1, "Consultor": 2}

    before_create :set_confirmation_number
    after_create :send_confirmation_number

    def json_object
        return {
            id: self.id,
            first_name: self.first_name,
            last_name: self.last_name,
            phone_number: self.phone_number,
            email: self.email,
            is_confirmed: self.is_confirmed,
            user_type: self.user_type,
            average_rating: self.average_rating,
            total_ratings: self.total_ratings,
            details: self.get_details
        }
    end

    def set_confirmation_number
        self.set_confirmation_number 
    end
    
    def send_confirmation_number
        # Enviar mensagem Zenvia
    end

    def get_details
        case self.user_type
        when "Empresa"
            details = Company.find_by(user_id: self.id)
        when "Estudante"
            details = Student.find_by(user_id: self.id)
        when "Consultor"
            details = Consultant.find_by(user_id: self.id)
        else
            return nil
        end

        return details.json_object
    end
    
end
