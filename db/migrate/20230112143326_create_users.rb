class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firebase_local_id, null: false
      t.boolean :active, null: false, :default => true
      t.timestamps
    end
  end
end
