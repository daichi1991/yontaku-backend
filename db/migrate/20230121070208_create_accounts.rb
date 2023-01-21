class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.references :payment_method, foreign_key: true
      t.boolean :active, null: false, :default => true
      t.timestamps
    end
  end
end
