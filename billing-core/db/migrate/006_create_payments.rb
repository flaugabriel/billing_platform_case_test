class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :status, default: 'created'
      t.string :method
      t.string :gateway_charge_id
      t.jsonb :gateway_response
      t.timestamps
    end
  end
end
