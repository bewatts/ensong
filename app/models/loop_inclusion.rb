class LoopInclusion < ActiveRecord::Base
  attr_accessible :loop_collection_id, :loop_id
  
  validates :loop_collection_id, :loop_id, :presence => true
  
  belongs_to :loop_collection, 
             :primary_key => :id, 
             :foreign_key => :loop_collection_id, 
             :class_name => "LoopCollection"
             
  belongs_to :loop, 
             :primary_key => :id, 
             :foreign_key => :loop_id, 
             :class_name => 'Loop'
             
end
