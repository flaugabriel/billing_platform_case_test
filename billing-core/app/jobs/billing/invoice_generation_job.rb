class Billing::InvoiceGenerationJob
  include Sidekiq::Worker

  def perform
    Subscription.active.each do |sub|
      invoice = Invoice.create!(
        client: sub.client,
        due_date: Date.today + 5.days,
        status: 'pending'
      )

      InvoiceItem.create!(
        invoice: invoice,
        product: sub.product,
        quantity: 1,
        unit_price_cents: sub.price_cents,
        total_cents: sub.price_cents
      )

      Billing::ChargePaymentService.call(invoice)
    end
  end
end
