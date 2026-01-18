class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :client, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :price_cents, null: false
      t.integer :cycle_day, null: false
      t.string :status, null: false, default: 'active'
      t.string :charge_type, null: false, default: 'recurring'
      t.timestamps
    end
  end
end
