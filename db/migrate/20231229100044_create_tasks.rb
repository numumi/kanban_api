class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :position
      t.text :description
      t.integer :lock_version, default: 0, null: false
      t.references :column, null: false, foreign_key: true
      t.timestamps
    end
  end
end
