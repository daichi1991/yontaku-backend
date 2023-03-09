class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :subject, type: :uuid, null: true, foreign_key: true
      t.string :name, null: false
      t.text :description, null: true
      t.timestamps
    end
  end
end
