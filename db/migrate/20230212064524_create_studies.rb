class CreateStudies < ActiveRecord::Migration[7.0]
  def change
    create_table :studies, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.integer :mode, null: false, limit: 2
      t.timestamps
    end
  end
end
