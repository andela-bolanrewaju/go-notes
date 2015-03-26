class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.string :category
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :notes, :users
    add_index :notes, [:user_id, :created_at]
  end
end
