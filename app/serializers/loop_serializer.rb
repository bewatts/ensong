class LoopSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :audio
  has_one :author
  
  def audio
    object.audio
  end
end
