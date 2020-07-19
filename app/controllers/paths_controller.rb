class PathsController < ApplicationController
    def index
        begin
            paths = Path.all

            paths = paths.map { |x| x.json_object }

            render json: {paths: paths}, status: 200
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            render status: 500
        end
    end
    
end