class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :client, null: false, foreign_key: true
      t.date :due_date
      t.string :status, null: false, default: 'pending'
      t.string :legacy_origin
      t.timestamps
    end
  end
end
