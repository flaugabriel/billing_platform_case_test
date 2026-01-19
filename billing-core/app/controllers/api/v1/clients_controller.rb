class Api::V1::ClientsController < ApplicationController

  def index
    clients = Client.all
    render json: clients
  end

  def create
    client = Client.create!(client_params)
    render json: client, status: :created
  end

  def show
    render json: Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:name, :document, :email, :billing_email, :payment_token)
  end
end
