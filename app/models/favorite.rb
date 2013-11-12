class Favorite < ActiveRecord::Base
  attr_accessible :loop_collection_id, :user_id
  belongs_to :loop_collection
  belongs_to :user
  
  validates :user_id, :uniqueness => { :scope => :loop_collection_id }
  validate :cannot_favorite_own_loop
  
  def cannot_favorite_own_loop
    if user_id == loop_collection.user.id
      self.errors[:user] << "The wise are not full of vanity.  One cannot favorite one's own things."
    end
  end
  
end
