class Loop < ActiveRecord::Base
  attr_accessible :author_id, :audio 
  has_attached_file :audio
  
  has_many :collection_inclusions, 
           :foreign_key => :loop_id, 
           :class_name => 'LoopInclusion', 
           :dependent => :destroy

  belongs_to :author, 
             :primary_key => :id, 
             :foreign_key => :author_id, 
             :class_name => "User"

           
  has_many :collections, :through => :collection_inclusions, :source => :loop_collection
  
  validates :author, :audio, :presence => true
  
  validates_attachment_content_type :audio, :content_type => ["audio/wav"]
  
end
