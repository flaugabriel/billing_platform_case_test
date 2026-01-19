class Api::V1::SubscriptionsController < ApplicationController

  def index
    @subscriptions = Subscription.all
    render json: @subscriptions
  end

  def updated_billing_date
    @subscriptions = Subscription.find(params[:id])
    @subscriptions.update(next_billing_at: Date.today)
    render json: @subscriptions
  end

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
