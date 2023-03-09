class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects, id: :uuid  do |t|
      t.string :key, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
