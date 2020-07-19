class MentorsController < ApplicationController
    before_action :authorized
    def index
        begin
            raise HackARocketExceptions::BadParameters if params[:start_timestamp].nil? || params[:path_id].nil?
            Time.zone = "America/Sao_Paulo"
            time_at = Time.zone.at(params[:start_time])
            start_time = time_at.hour*3600
            weekday = time_at.wday

            id_raw_available_users = RegularTime.where(start_time: start_time, weekday: weekday).pluck(:user_id)
            busy_users = Appointment.where(start_timestamp: start_timestamp).select(:mentor_id).distinct.pluck(:mentor_id)

            path_users = UserPath.where(path_id: params[:path_id]).where.not(user_id: busy_users).pluck(:user_id)
            id_available_users = path_users - (id_raw_available_users - busy_users)

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