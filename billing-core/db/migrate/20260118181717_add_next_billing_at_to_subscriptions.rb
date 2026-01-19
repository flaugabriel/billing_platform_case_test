class AddNextBillingAtToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :next_billing_at, :datetime
  end
end
