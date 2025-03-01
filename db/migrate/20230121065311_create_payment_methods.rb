class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_methods, id: :uuid do |t|
      t.string :key, null: false, unique: true
      t.string :name, null: false
      t.timestamps
    end
  end
end
