class RatingsController < ApplicationController
    before_action :authorized
    
    def create
        begin
            
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
        end
    end
    
end