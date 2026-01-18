class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :document, null: false
      t.string :email
      t.string :billing_email
      t.string :payment_token
      t.timestamps
    end

    add_index :clients, :document, unique: true
  end
end
