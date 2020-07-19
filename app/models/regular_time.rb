class RegularTime < ApplicationRecord
    acts_as_paranoid

    def json_object
        return {
            id: self.id,
            user_id: self.user_id,
            start_time: self.start_time,
            end_time: self.end_time,
            weekday: self.weekday
        }
    end
    
end
