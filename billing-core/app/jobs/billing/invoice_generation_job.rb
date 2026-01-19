class Billing::InvoiceGenerationJob
  include Sidekiq::Worker

  def perform
    Subscription.active.where(next_billing_at: Date.today).each do |sub|
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

      Billing::PaymentProcessingJob.perform_async(invoice.id)


      sub.update!(next_billing_at: sub.next_billing_at + 1.month)
    end
  end
end
