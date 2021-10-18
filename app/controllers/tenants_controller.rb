class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = find_tenant
        render json: tenant, status: :ok
    end

    def create
        new_tenant = Tenant.create(tenant_params)
        render json: new_tenant, status: :created
    end

    def destroy
        find_tenant.destroy
    end

    def update
        tenant = find_tenant
        tenant.update(tenant_params)
        render json: tenant, status: :ok
    end


    private

    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find(params[:id])
    end

end
