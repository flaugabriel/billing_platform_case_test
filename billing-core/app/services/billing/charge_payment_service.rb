class Billing::ChargePaymentService
  def self.call(invoice)
    client = invoice.client

    response = Faraday.post("#{ENV['GATEWAY_URL']}/charges") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        amount: invoice.total_cents,
        customerId: client.id,
        paymentMethod: invoice.payment_method,
        invoiceId: invoice.id
      }.to_json
    end

    data = JSON.parse(response.body)

    Payment.create!(
      invoice: invoice,
      status: 'processing',
      payment_method: invoice.payment_method,
      gateway_charge_id: data['charge_id']
    )
  end
end
