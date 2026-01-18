class Payment < ApplicationRecord
  belongs_to :invoice

  enum status: {
    created: 'created',
    processing: 'processing',
    paid: 'paid',
    refused: 'refused',
    refunded: 'refunded'
  }
end
