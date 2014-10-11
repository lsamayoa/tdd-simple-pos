module AuthorizedResource
  extend ActiveSupport::Concern

  included do
    attr_reader :resource, :scope
    before_action :set_and_authorize_resource, only: [:show, :edit, :update, :destroy]
  
    def index
      @resources = policy_scope(scope).all
      respond_with(@resources)
    end

    def show
      respond_with(@resource)
    end

    def new
      @resource = scope.new
      respond_with(@resource)
    end

    def edit
    end

    def create
      @resource = current_user.employees.create(resource_params)
      respond_with(@resource)
    end

    def update
      @resource.update(resource_params)
      respond_with(@resource)
    end

    def destroy
      @resource.destroy
      respond_with(@resource)
    end

  end

  def scope
    controller_name.classify.constantize
  end

  def set_and_authorize_resource
    @resource = scope.find(params[:id])
    authorize @resource
  end

end