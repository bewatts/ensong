class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id, :null => false
      t.integer :loop_collection_id, :null => false

      t.timestamps
    end
    add_index :favorites, [:user_id, :loop_collection_id]
  end
end
