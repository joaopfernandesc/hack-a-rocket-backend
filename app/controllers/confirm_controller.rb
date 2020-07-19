class ConfirmController < ApplicationController
    before_action :authorized
    def create
        begin
            params[:confirmation_number] == @user[:confirmation_number] ? @user.update(is_confirmed: true) : (raise HackARocketExceptions::UnauthorizedOperation)

            render json: {msg: "Confirmed."}, status: 201
        rescue HackARocketExceptions::UnauthorizedOperation
            render json: {msg: "You do not have permission to do this."}, status: 401
        rescue ActiveRecord::RecordNotFound
            render json: {msg: "Not found."}, status: 404
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
        end
    end
    
end