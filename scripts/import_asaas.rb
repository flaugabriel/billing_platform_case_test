require 'csv'
require 'faraday'
require 'json'

ASAAS_API_KEY = ENV['ASAAS_API_KEY']
PAGARME_API_KEY = ENV['PAGARME_API_KEY']

class AsaasImporter
  def self.import_customers
    customers = fetch_asaas("/customers")
    customers.each do |c|
      client = Client.find_or_initialize_by(asaas_id: c['id'])
      client.update!(
        name: c['name'],
        email: c['email'],
        phone: c['phone'],
        document: c['cpfCnpj'],
        payer_external_id: create_pagarme_customer(c)
      )
    end
  end

  def self.import_subscriptions
    subs = fetch_asaas("/subscriptions")
    subs.each do |s|
      client = Client.find_by(asaas_id: s['customer'])
      next unless client

      Subscription.create!(
        client: client,
        product: Product.find_by(name: s['description']) || Product.first,
        price_cents: (s['value'] * 100).to_i,
        payment_method: map_payment_method(s['billingType']),
        next_billing_at: Date.parse(s['nextDueDate'])
      )
    end
  end

  private

  def self.fetch_asaas(path)
    response = Faraday.get("https://www.asaas.com/api/v3#{path}") do |req|
      req.headers['access_token'] = ASAAS_API_KEY
    end

    JSON.parse(response.body)['data']
  end

  def self.create_pagarme_customer(customer)
    response = Faraday.post("https://api.pagar.me/core/v5/customers") do |req|
      req.headers['Authorization'] = "Bearer #{PAGARME_API_KEY}"
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        name: customer['name'],
        email: customer['email'],
        phone: customer['phone'],
        document: customer['cpfCnpj']
      }.to_json
    end

    JSON.parse(response.body)['id']
  end

  def self.map_payment_method(type)
    case type
    when 'BOLETO'
      :boleto
    when 'CREDIT_CARD'
      :credit_card
    when 'PIX'
      :pix
    else
      :credit_card
    end
  end
end

AsaasImporter.import_customers
AsaasImporter.import_subscriptions
