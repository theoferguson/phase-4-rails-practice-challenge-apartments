class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = find_apartment
        render json: apartment, status: :ok
    end

    def create
        new_apartment = Apartment.create!(apartment_params)
        render json: new_apartment, status: :created
    end

    def destroy
        find_apartment.destroy
    end

    def update
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment
    end


    private

    def apartment_params
        params.permit(:number)
    end

    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def find_apartment
        Apartment.find(params[:id])
    end

end
