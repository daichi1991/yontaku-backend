class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects, id: :uuid  do |t|
      t.string :key, null: false, unique: true
      t.string :name, null: false, unique: true
      t.string :image
      t.timestamps
    end
  end
end
