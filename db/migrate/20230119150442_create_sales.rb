class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :product, foreign_key: true
      t.integer :price, null: false
      t.boolean :publish, null: false
      t.timestamps
    end
  end
end
