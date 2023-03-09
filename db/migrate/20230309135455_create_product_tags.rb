class CreateProductTags < ActiveRecord::Migration[7.0]
  def change
    create_table :product_tags, id: :uuid do |t|
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.references :tag, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
