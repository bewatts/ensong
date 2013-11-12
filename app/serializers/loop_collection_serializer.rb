class LoopCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :isFavoritedByCurrentUser, :numFavorites, :isOwnedByCurrentUser, :userNotLoggedIn
  has_many :loops
  
  def isFavoritedByCurrentUser
    if scope
      object.favorites.pluck(:user_id).include?(scope.id)
    else
      false
    end    
  end
  
  def numFavorites
    object.num_of_favorites  
  end
  
  def isOwnedByCurrentUser
    if scope
      object.user_id == scope.id
    else
      false
    end 
  end
       
  def userNotLoggedIn
    !scope
  end
  
end
