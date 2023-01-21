class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :product, foreign_key: true
      t.integer :number, null: false
      t.text :question, null: false
      t.timestamps
    end
  end
end
