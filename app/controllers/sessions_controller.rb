class UserSessionsController < ApplicationController
    def create
        begin
            raise HackARocketExceptions::BadParameters if params[:email].nil? || params[:password].nil?

            user = User.find_by(email: params[:email])

            raise HackARocketExceptions::UnauthorizedOperation if user.nil?

            if user.authenticate(params[:password])
                token = encode_token({ id: user[:id], type: type })
            else
                raise HackARocketExceptions::UnauthorizedOperation
            end

            render json: { token: token, user: user.json_object }, status: 201
        rescue HackARocketExceptions::UnauthorizedOperation
            render json: { error: 'Incorrect user/password combination' }, status: 401
          rescue HackARocketExceptions::BadParameters
            render json: { error: 'Bad parameters' }, status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
        end
        
    end
end