class Api::V1::WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def payment
    payment = Payment.find_by(gateway_charge_id: params[:charge_id])

    case params[:status]
    when 'paid'
      payment.update!(status: 'paid')
      payment.invoice.update!(status: 'paid')
    when 'failed'
      payment.update!(status: 'failed')
      payment.invoice.update!(status: 'failed')
    end

    head :ok
  end
end
