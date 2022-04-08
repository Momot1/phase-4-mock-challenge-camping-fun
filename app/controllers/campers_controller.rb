class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, :with => :rescue_from_not_found

    def index
        render json: Camper.all
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperActivitiesSerializer
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def rescue_from_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end



end
