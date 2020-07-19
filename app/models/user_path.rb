class UserPath < ApplicationRecord
    def json_object
        return {
            id: self.id,
            path_id: self.path_id,
            user_id: self.user_id
        }
    end
    
end
