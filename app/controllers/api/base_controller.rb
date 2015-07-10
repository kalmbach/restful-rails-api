module Api
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :set_resource, only: [:destroy, :show, :update]
    respond_to :json

    # POST /api/{plural_resource_name}
    def create
      set_resource(resource_class.new(resource_params))

      if get_resource.save
        render :show, status: :created
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/{plural_resource_name}/:id
    def destroy
      get_resource.destroy
      head :no_content
    end

    # GET /api/{plural_resource_name}/:id
    def show
      respond_with get_resource
    end

    # PATCH/PUT /api/{plural_resource_name}/:id
    def update
      if get_resource.update(resource_params)
        head :no_content
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # GET /api/{plural_resource_name}
    def index
      plural_resource_name = "@#{resource_name.pluralize}"
      resources = resource_class.where(query_params)
                                .page(page_params[:page])
                                .per(page_params[:page_size])

      instance_variable_set(plural_resource_name, resources)
      respond_with instance_variable_get(plural_resource_name)
    end

    private

      # Returns the resource from the created instance variable
      def get_resource
        instance_variable_get("@#{resource_name}")
      end

      # Use callbacks to share common setup or constraints between actions
      def set_resource(resource = nil)
        resource ||= resource_class.find(params[:id])
        instance_variable_set("@#{resource_name}", resource)
      rescue ActiveRecord::RecordNotFound
        render json: { exception: 'Record not found.' }, status: :not_found
      end

      # Returns the allowed parameters for searching.
      # Override this method in each API controller
      # to permit additional parameters to search on
      def query_params
        {}
      end

      # Returns the allowed parameters for pagination
      def page_params
        params.permit(:page, :page_size)
      end

      # The resource class based on the controller
      def resource_class
        @resource_class ||= resource_name.classify.constantize
      end

      # The singular name for the resource class based on the controller
      def resource_name
        @resource_name ||= self.controller_name.singularize
      end

      # Only allow a trusted parameter "white list" through.
      # If a single resource is loaded for #create or #update,
      # then the API controller must implement the method
      # "#{resource_name}_params" to limit permitted parameters
      # for the model.
      def resource_params
        @resource_params ||= self.send("#{resource_name}_params")
      end
  end
end
