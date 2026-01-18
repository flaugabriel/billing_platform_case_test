class Subscription < ApplicationRecord
  belongs_to :client
  belongs_to :product

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
end
