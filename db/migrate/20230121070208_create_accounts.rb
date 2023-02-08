class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :payment_method, type: :uuid, null: false, foreign_key: true
      t.boolean :active, null: false, :default => true
      t.timestamps
    end
  end
end
