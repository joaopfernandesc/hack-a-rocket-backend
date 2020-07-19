class AppointmentsController < ApplicationController
    before_action :authorized
    def create
        begin
            appointment = Appointment.new(create_params)
            appointment[:responsible_id] = @user[:id]
            appointment.save

            render json: appointment.json_object, status: 201
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end

    def index
        begin
            appointment = Appointment
                            .where(responsible_id: @user[:id])
                            .or(Appointment.where(mentor_id: @user[:id]))
                            .order("start_timestamp ASC")

            appointments = appointment.map(&:json_object)
                        
            render json: appointments, status: 200
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    def show
        begin
            appointment = Appointment.find(params[:id])

            render json: appointment.json_object
        rescue ActiveRecord::RecordNotFound
            render json: {error: "Not found."}, status: 404
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
        
    end
    def destroy
        begin
            appointment = Appointment.find(params[:id])
            if appointment[:mentor_id] == @user[:id] || appointment[:responsible_id] == @user[:id]
                appointment.update(canceled_id: @user[:id], is_canceled: true)
                appointment.destroy 
            else 
                raise HackARocketExceptions::UnauthorizedOperation
            end

            render status: 204
        rescue HackARocketExceptions::UnauthorizedOperation
            render json: {error: "Unauthorized"}, status: 401
        rescue ActiveRecord::RecordNotFound
            render json: {error: "Not found."}, status: 404
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end    
    
    def create_params
        params.permit(:mentor_id, :start_timestamp, :end_timestamp, :path_id)
    end
    
end