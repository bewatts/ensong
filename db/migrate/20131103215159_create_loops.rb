class CreateLoops < ActiveRecord::Migration
  def change
    create_table :loops do |t|
      t.integer :author_id
      t.timestamps
    end
    add_attachment :loops, :audio
    add_index :loops, :author_id
  end
end
