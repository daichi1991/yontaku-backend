class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :account, type: :uuid, null: false, foreign_key: true
      t.references :sale, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
