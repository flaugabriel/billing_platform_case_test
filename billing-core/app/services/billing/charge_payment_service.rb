class Billing::ChargePaymentService
  def self.call(invoice)
    client = invoice.client
    p '232423423424234244444charnge'
    body = {
      amount: invoice.total_cents,
      customerId: client.id,
      paymentMethod: 0,
      invoiceId: invoice.id,
      change_id: 'teste'
    }.to_json

    # aqui e um exemplo de como fazer a requisição para o gateway
    # response = Faraday.post("#{ENV['GATEWAY_URL']}/charges") do |req|
    #   req.headers['Content-Type'] = 'application/json'
    #   req.body = {
    #     amount: invoice.total_cents,
    #     customerId: client.id,
    #     paymentMethod: invoice.payment_method,
    #     invoiceId: invoice.id
    #   }.to_json
    # end
    #
    # data = JSON.parse(response.body)

    data = JSON.parse(body)
    puts data

    Payment.create!(
      invoice: invoice,
      status: 'processing',
      payment_method: 0,
      gateway_charge_id: data['charge_id']
    )
  end
end
