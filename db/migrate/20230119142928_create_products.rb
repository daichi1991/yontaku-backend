class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.text :description, null: true
      t.timestamps
    end
  end
end
