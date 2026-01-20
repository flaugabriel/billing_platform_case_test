class Api::V1::WebhooksController < ApplicationController
  def payment
    payment = Payment.find_by(gateway_charge_id: params[:charge_id])

    puts payment
    puts nil
    if payment.nil?
      render json: { error: 'payment not found' }, status: :not_found
    else
      case params[:status]
      when 'paid'
        payment.update!(status: 'paid')
        payment.invoice.update!(status: 'paid')
      when 'failed'
        payment.update!(status: 'failed')
        payment.invoice.update!(status: 'failed')
      else
        render json: { error: 'unknown status' }, status: :bad_request
      end

      render json: payment, status: :ok
    end
  end
end
