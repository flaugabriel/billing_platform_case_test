class Api::V1::SubscriptionsController < ApplicationController
  def create
    sub = Subscription.create!(sub_params)
    render json: sub, status: :created
  end

  def cancel
    sub = Subscription.find(params[:id])
    sub.update!(status: 'cancelled')
    render json: sub
  end

  private

  def sub_params
    params.require(:subscription).permit(:client_id, :product_id, :price_cents, :cycle_day, :charge_type)
  end
end
