class Post < ApplicationRecord
	has_many :comments, dependent: :destroy
	
	validates :title, presence: true
	validates :content, presence: true, length: { minimum: 10 }

	after_create_commit -> { broadcast_append_later_to 'posts' }
	after_update_commit -> { broadcast_replace_later_to 'posts' }
	after_destroy_commit -> { broadcast_remove_to 'posts' }
end
