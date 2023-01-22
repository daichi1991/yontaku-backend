class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true
      t.text :answer, null: false
      t.boolean :correct, null: false
      t.timestamps
    end
  end
end
