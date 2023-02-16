class CreateStudyDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :study_details, id: :uuid do |t|
      t.references :study, type: :uuid, null: false, foreign_key: true
      t.references :question, type: :uuid, null: false, foreign_key: true
      t.references :answer, type: :uuid, null: true, foreign_key: true
      t.boolean :skip, null: false
      t.integer :required_milliseconds, null: false
      t.boolean :score_target, null: false, :default => true
      t.timestamps
    end
  end
end
