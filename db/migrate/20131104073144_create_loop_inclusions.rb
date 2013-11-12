class CreateLoopInclusions < ActiveRecord::Migration
  def change
    create_table :loop_inclusions do |t|
      t.integer :loop_id
      t.integer :loop_collection_id

      t.timestamps
    end
    add_index :loop_inclusions, [:loop_id, :loop_collection_id]
  end
end
