class UserPathsController < ApplicationController
    before_action :authorized

    def destroy
        begin
            user_path = UserPath.find(params[:id])

            raise HackARocketExceptions::UnauthorizedOperation if user_path[:user_id] != @user[:id]

            user_path.destroy

            render status: 204
        rescue HackARocketExceptions::UnauthorizedOperation
            render json: {error: "Unauthorized"}, status: 401
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    def create
        begin
            raise HackARocketExceptions::BadParameters if params[:user_id].nil? || params[:path_id].nil?
            
            user_path = UserPath.create(create_params)

            render json: user_path.json_object, status: 201
        rescue HackARocketExceptions::BadParameters
            render json: {error: "Bad parameters."}, status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    def create_params
        params.permit(:path_id, :user_id)
    end
    
end