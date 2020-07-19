class UsersController < ApplicationController
    before_action :authorized, only: [:update, :show]
    def create
        begin
            user = User.new(user_params)
            User.transaction do
                user.save
                case params[:user_type]
                when "Consultor"
                    attached = Consultant.new(consultant_params)
                when "Estudante"
                    attached = Student.new(student_params)                    
                when "Empresa"
                    attached = Company.new(company_params)
                else
                    raise HackARocketExceptions::BadParameters
                end
                user_paths = params[:path_ids].map {|x| {user_id: user[:id], path_id: x} }
                UserPath.create(user_paths) if user_paths.size > 0
                attached[:user_id] = user[:id]
                attached.save!
            end

            render json: user.json_object, status: 201
        rescue HackARocketExceptions::BadParameters
            render status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    
    def update
        begin
            @user.update(user_params)

            render json: @user.json_object, status: 204
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    def show
        begin
            id = params[:id]

            user = User.find(id)

            render json: user.json_object, status: 200
        rescue ActiveRecord::RecordNotFound
            render status: 404
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end   
    
    private

    def user_params
        params.permit(:first_name, :last_name, :email, :phone_number, :user_type, :password)
    end

    def consultant_params
        params.permit(:college_name, :experience_years, :website, :graduation_course, :description)
    end
    def student_params
        params.permit(:college_name, :current_semester, :registration_number, :graduation_course, :description, :website)
    end
    def company_params
        params.permit(:CNPJ, :category)
    end
end