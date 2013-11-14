class LoopCollection < ActiveRecord::Base
  
  NUM_LOOPS = 9
  TOTAL_SIZE = 4_000_000  #4MB as far as I can tell. 
  TITLE_SIZE = 32
    
  attr_accessible :title, :user_id
  
  belongs_to :user, :inverse_of => :loop_collections
  has_many :favorites, :dependent => :destroy
  has_many :user_favorites, :through => :favorites, :source => :user
  
  has_many :loop_inclusions, 
           :primary_key => :id, 
           :foreign_key => :loop_collection_id, 
           :class_name => 'LoopInclusion', 
           :dependent => :destroy
           
  has_many :loops, :through => :loop_inclusions, :source => :loop
  
  validates :title, :presence => true, :length => {:maximum => TITLE_SIZE}
  validates_presence_of :user
  validate :must_have_right_num_and_size_of_loops
  
  def must_have_right_num_and_size_of_loops
    val = (must_have_right_num_of_loops && must_be_right_size)
    return val
  end
  
  def must_have_right_num_of_loops
    if loops.length == NUM_LOOPS && loops.all{|loop| loop.audio_file_size != nil }
      return true
    else
      errors.add( :loops, "Incorrect number of loops.  Must have #{NUM_LOOPS}" )
      return false;
    end
  end
  
  def num_of_favorites
    favorites.count
  end
  
  def must_be_right_size
    total_size = 0
    loops.each {|loop| total_size += loop.audio_file_size}
    
    if total_size > TOTAL_SIZE 
      errors.add(:loops, "Your loops are overly immense. You have #{TOTAL_SIZE - total_size} too many bytes.") 
      return false;
    else 
      return true
    end
  end
  
  def clone( options = {} )
    title = options["title"] || "Meditation on #{self.title}"
    cloned = LoopCollection.new
    self.loops.each {|l| cloned.loops << l }    
    cloned.title = "Meditation on #{self.title}"
    return cloned
  end
  
  def LoopCollection.copy_random_collection(user)
    all_collections = LoopCollection.all.shuffle
    viable_collections = all_collections.select{|l| l.title.length + 14 < TITLE_SIZE }
    
    if viable_collections.length > 0
      options = {}
    else
      options = {"title" => "Meditation #{all_collections.length}"}
      viable_collections << all_collections.first
    end
    
    new_collection = viable_collections.first.clone(options)
    return new_collection
  end 
  
  def LoopCollection.select_by_date
    LoopCollection.includes(:favorites).order("created_at DESC")
  end           
  
  def LoopCollection.select_by_favorites
    LoopCollection.includes(:favorites).
                   select("loop_collections.*, COUNT(favorites.id) AS favorites_count").
                   joins("LEFT OUTER JOIN favorites ON loop_collections.id = favorites.loop_collection_id").
                   group('loop_collections.id').
                   order("favorites_count DESC")
  end           
end
