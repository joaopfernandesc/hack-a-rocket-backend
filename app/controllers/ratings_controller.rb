class RatingsController < ApplicationController
    before_action :authorized

  def create
        begin
            raise HackARocketExceptions::BadParameters if params[:user_id].nil? || params[:rating]

            user = User.find(id: params[:user_id])
            raise HackARocketExceptions::NotFound if user.nil?

            params.permit(:rating, :user_id)
            total_ratings = user[:total_ratings] + 1
            if total_ratings == 1
                average_rating = params[:rating]
            else
                average_rating = (user[:average_rating]*(user[:total_ratings]-1) + params[:rating].to_f)/total_ratings
            end
            
            user.update(average_rating: average_rating, total_ratings: total_ratings)

            render status: 204
        rescue HackARocketExceptions::NotFound
            render json: { error: 'Not found' }, status: 404
        rescue HackARocketExceptions::BadParameters
            render json: { error: 'Bad parameters'}, status: 422
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
  end  
    
end