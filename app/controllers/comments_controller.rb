class CommentsController < ApplicationController
	def show
	end

	def new
		@comment = Comment.new
	end

	def create 
		@post = Post.find(params[:post_id])

		respond_to do |format|
			if @post.comments.create(comment_params)
			  format.html { redirect_to post_path(@post), notice: "Comment was successfully created." }
			else
			  format.html { redirect_to post_path(@post), status: :unprocessable_entity }
			end
		end
	end
	private
	def set_comment 
		@comment = Comment.find(params[:id])
	end

    def comment_params
      params.require(:comment).permit(:author, :message)
    end
end
