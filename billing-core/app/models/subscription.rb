class Subscription < ApplicationRecord
  belongs_to :client
  belongs_to :product

  enum payment_method: { credit_card: 0, boleto: 1, pix: 2 }
  enum status: {
    active: 'active',
    trial: 'trial',
    suspended: 'suspended',
    cancelled: 'cancelled'
  }

  enum charge_type: {
    recurring: 'recurring',
    one_off: 'one_off'
  }

  scope :active, -> { where(status: :active) }
end
