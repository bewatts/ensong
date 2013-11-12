class LoopCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :loops
  has_many :favorites
  
end
