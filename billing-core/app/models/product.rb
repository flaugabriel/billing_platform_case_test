class Product < ApplicationRecord
  has_many :subscriptions
  has_many :invoice_items

  validates :name, :kind, presence: true
end
