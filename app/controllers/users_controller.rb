class UsersController < ApplicationController
    def create
        begin
            
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
        end
    end
    
    def update
        
    end
    def show
        
    end   
    
end