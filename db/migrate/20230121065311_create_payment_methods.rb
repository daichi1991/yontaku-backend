class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_methods do |t|
      t.string :payment_method, null: false
      t.timestamps
    end
  end
end
