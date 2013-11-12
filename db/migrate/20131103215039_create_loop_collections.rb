class CreateLoopCollections < ActiveRecord::Migration
  def change
    create_table :loop_collections do |t|
      t.string :title
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_index :loop_collections, :user_id
  end
end
