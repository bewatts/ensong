class LoopCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :isFavoritedByCurrentUser, :numFavorites, :isOwnedByCurrentUser, :userNotLoggedIn
  has_many :loops
  has_one :user
  
  def isFavoritedByCurrentUser
    scope ? object.favorites.pluck(:user_id).include?(scope.id) : false
  end
  
  def numFavorites
    object.num_of_favorites  
  end
  
  def isOwnedByCurrentUser
    scope ? object.user_id == scope.id : false
  end
       
  def userNotLoggedIn
    !scope
  end
  
end
