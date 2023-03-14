class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.integer :rate, limit: 1, null: false
      t.timestamps
    end
  end
end
