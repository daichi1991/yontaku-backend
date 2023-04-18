class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :uid, null: false, unique: true
      t.string :username, null: true
      t.string :description, null: true
      t.string :image
      t.boolean :active, null: false, :default => true
      t.timestamps
    end
  end
end
