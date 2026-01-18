class Api::V1::WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def payment
    payment = Payment.find_by(gateway_charge_id: params[:charge_id])

    if payment
      payment.update!(
        status: params[:status],
        gateway_response: params[:raw]
      )

      payment.invoice.update!(status: map_invoice_status(payment.status))
    end

    head :ok
  end

  private

  def map_invoice_status(status)
    case status
    when 'paid' then 'paid'
    when 'refused' then 'overdue'
    else 'pending'
    end
  end
end
