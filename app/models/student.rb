class Student < ApplicationRecord
    def json_object
        return {
            user_id: self.user_id,
            college_name: self.college_name,
            registration_number: self.registration_number,
            graduation_course: self.graduation_course,
            website: self.website,
            description: self.description
        }
    end
    
end
