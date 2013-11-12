class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :loop_collection_id, :isCurrentUserFavorite, :isOwnedByCurrentUser, :userNotLoggedIn
  
  def isCurrentUserFavorite
    if scope
      object.user_id == scope.id
    else
      false
    end
  end
  
  def isOwnedByCurrentUser
    if scope
      LoopCollection.find(object.loop_collection_id).user.id == scope.id
    else
      false
    end
  end
  
  def userNotLoggedIn
    !scope
  end
  
end
