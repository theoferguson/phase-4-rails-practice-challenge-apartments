class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        leases = Lease.all
        render json: leases, status: :ok
    end


    def create
        new_lease = Lease.create(lease_params)
        render json: new_lease, status: :created
    end

    def destroy
        Lease.find_by(id: params[:id]).destroy
    end

    private

    def render_not_found_response
        render json: { error: "Lease not found" }, status: :not_found
    end

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end

end
