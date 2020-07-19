class Rating < ApplicationRecord

    def json_object
        to_user = User.find(self.to_id).json_object
        from_user = User.find(self.from_id).json_object
        appointment = Appointment.find(self.appointment_id) if !self.appointment_id.nil?
        return {
            description: self.description,
            to_user: to_user,
            from_user: from_user,
            appointment: appointment,
            rating: self.rating
        }
    end
    
end
