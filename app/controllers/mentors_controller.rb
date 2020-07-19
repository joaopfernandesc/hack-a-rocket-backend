class MentorsController < ApplicationController
    before_action :authorized
    def index
        begin
            raise HackARocketExceptions::BadParameters if params[:start_timestamp].nil? || params[:path_id].nil?

            busy_users = Appointment.where(start_timestamp: start_timestamp).select(:mentor_id).distinct.pluck(:mentor_id)
            id_available_users = UserPath.where(path_id: params[:path_id]).where.not(user_id: busy_users).pluck(:user_id)

            available_users = User.where(id: id_available_users).order("average_rating ASC").map(&:json_object)
            
            render json: available_users, status: 200
        rescue HackARocketExceptions::BadParameters
            render json: {error: "Bad parameters."}, status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    
end