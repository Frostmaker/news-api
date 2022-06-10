class CommentsController < ApplicationController
	def show
	end

	private

	def set_comment 
		@comment = Comment.find(params[:id])
	end

	def comment
end
