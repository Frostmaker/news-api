class Comment < ApplicationRecord
  belongs_to :post

  after_create_commit -> { broadcast_append_later_to 'comments' }
  after_destroy_commit -> { broadcast_remove_to 'comments' }
end
