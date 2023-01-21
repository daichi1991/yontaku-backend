class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :account, foreign_key: true
      t.references :sale, foreign_key: true
      t.timestamps
    end
  end
end
