class RegularTimesController < ApplicationController
    before_action :authorized
    def create
        begin
            raise HackARocketExceptions::BadParameters if params[:weekday].nil? || params[:start_time].nil? || params[:end_time].nil?
            rt = RegularTime.new(times_create_params)
            rt[:user_id] = @user[:id]
            rt.save!

            render json: rt.json_object, status: 201
        rescue HackARocketExceptions::BadParameters
            render json: {error: "Bad parameters"}, status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    def index
        begin
            raise HackARocketExceptions::BadParameters if params[:user_id.nil?]
            user_id = params[:user_id]

            rts = RegularTime.where(user_id: user_id)

            rts = rts.map { |x| x.json_object }

            render json: rts, status: 200
        rescue HackARocketExceptions::BadParameters
            render json: {error: "Bad parameters"}, status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end    
    def destroy
        begin
            rt = RegularTime.find(params[:id])
            rt.destroy

            render status: 204
        rescue ActiveRecord::RecordNotFound
            render json: {error: "Not found"}, status: 404
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end

    def times_create_params
        params.permit(:weekday, :start_time, :end_time)
    end
    
end