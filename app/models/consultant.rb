class Consultant < ApplicationRecord
    def json_object
        return {
            user_id: self.user_id,
            college_name: self.college_name,
            experience_years: self.experience_years,
            website: self.website,
            graduation_course: self.graduation_course,
            description: self.description
        }
    end
    
end
