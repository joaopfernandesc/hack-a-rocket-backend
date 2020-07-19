class Company < ApplicationRecord
    def json_object
        return {
            user_id: self.user_id,
            CNPJ: self.CNPJ,
            category: self.category,
            company_name: self.company_name
        }
    end
    
end
