class Path < ApplicationRecord
    def json_object
        return {
            id: self.id,
            name: self.name
        }
    end
    
end
