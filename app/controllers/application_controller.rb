class ApplicationController < ActionController::API
    include HackARocketExceptions
    before_action :authorized
    
    def encode_token(payload)
        JWT.encode(payload, ENV['SECRET_JWT'])
    end

    def auth_header
        request.headers['Authorization']
    end

    def encoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            JWT.decode(token, ENV['SECRET_JWT'], true, algorithm: 'HS256')
        end        
    end
    
    def logged_in_user
        if decoded_token
            id = decoded_token[0]['id']
            type = decoded_token[0]['type']
            if type == 'consultant'
               @consultant = Consultant.find(id) 
            else

            end
        end
    end

    def logged_in?
        !!logged_in_user
    end
    
    def authorized
        begin
            logged_in?    
        rescue JWT::VerificationError
            render json: {error: 'Unauthorized token'},status: 401
        rescue JWT::DecodeError
            render status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
        end
    end
end
