class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :product, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.boolean :publish, null: false
      t.timestamps
    end
  end
end
