class Billing::PaymentProcessingJob
  include Sidekiq::Worker

  sidekiq_options retry: 5 # opcional, ajustável

  def perform(invoice_id)
    invoice = Invoice.find(invoice_id)
    Billing::ChargePaymentService.call(invoice)
  end
end
