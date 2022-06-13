class CommentsController < ApplicationController
	before_action :set_comment, except: [:create, :new]
	
	
	def show
		respond_to do |format|
			format.json { render json: @comment }
		  end
	end

	def new
		@comment = Comment.new
	end

	def create 
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comment_params)
		respond_to do |format|
			if @comment.save
			  format.turbo_stream
			  format.html { redirect_to post_path(@post), notice: "Comment was successfully created." }
			else
				format.turbo_stream
			  	format.html { redirect_to post_path(@post), status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@post = Post.find(params[:post_id])

		@comment.destroy

		respond_to do |format|
		  format.turbo_stream { redirect_to post_path(@post), target: '_top', notice: "Post was successfully destroyed." }
		  format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
		  format.json { head :no_content }
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
