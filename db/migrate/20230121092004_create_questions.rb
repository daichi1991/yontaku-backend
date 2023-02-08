class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.integer :number, null: false
      t.text :question, null: false
      t.timestamps
    end
  end
end
