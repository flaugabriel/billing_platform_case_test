class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_items
  has_one :payment

  enum payment_method: { credit_card: 0, boleto: 1, pix: 2 }
  enum status: {
    pending: 'pending',
    paid: 'paid',
    overdue: 'overdue',
    cancelled: 'cancelled'
  }


  def total_cents
    invoice_items.sum(:total_cents)
  end
end
