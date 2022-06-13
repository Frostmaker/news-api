class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author, :message
  belongs_to :post
end
