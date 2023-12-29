class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.string :name
      t.integer :position
      t.integer :lock_version, default: 0, null: false
      t.references :board, null: false, foreign_key: true
      t.timestamps
    end
  end
end
