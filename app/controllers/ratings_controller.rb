class RatingsController < ApplicationController
    before_action :authorized

    def create
        begin
            raise HackARocketExceptions::BadParameters if params[:user_id].nil? || params[:rating].nil?

            Rails.logger.info params[:user_id]
            user = User.find(params[:user_id])
            raise HackARocketExceptions::NotFound if user.nil?

            params.permit(:rating, :user_id)
            total_ratings = user[:total_ratings] + 1
            if total_ratings == 1
                average_rating = params[:rating]
            else
                average_rating = (user[:average_rating]*(user[:total_ratings]) + params[:rating].to_f)/total_ratings
            end
            User.transaction do
                to_id = params[:user_id]
                from_id = @user[:id]
                Rating.create(to_id: to_id, from_id: from_id, description: params[:description], appointment_id: params[:appointment_id], rating: params[:rating])
                user.update(average_rating: average_rating, total_ratings: total_ratings)
            end

            render status: 204
        rescue HackARocketExceptions::NotFound
            render json: { error: 'Not found' }, status: 404
        rescue HackARocketExceptions::BadParameters
            render json: { error: 'Bad parameters'}, status: 400
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    def index
        begin
            ratings = Rating.where(to_id: params[:user_id])
            total = ratings.count

            render json: ratings.map(&:json_object), status: 200
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end 
end