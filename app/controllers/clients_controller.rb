class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = policy_scope(Client).all
    respond_with(@clients)
  end

  def show
    authorize @client
    respond_with(@client)
  end

  def new
    @client = Client.new
    respond_with(@client)
  end

  def edit
    authorize @client
  end

  def create
    @client = current_user.clients.build(client_params)
    @client.save
    respond_with(@client)
  end

  def update
    @client.update(client_params)
    respond_with(@client)
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  private
    def set_and_authorize_client
      set_client
      authorize_client
    end

    def authorize_client
      authorize @client
    end

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name, :email)
    end
end
