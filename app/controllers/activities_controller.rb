class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, :with => :rescue_from_not_found

    def index
        render json: Activity.all
    end

    def destroy
        activity = Activity.find(params[:id])
        activity.destroy

    end

    private

    def rescue_from_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end
end
