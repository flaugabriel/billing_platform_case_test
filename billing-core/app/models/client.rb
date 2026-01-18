class Client < ApplicationRecord
  has_many :subscriptions
  has_many :invoices
end
