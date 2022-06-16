# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy show]

  def show
    respond_to do |format|
      format.turbo_stream
      format.json { render json: @comment }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    respond_to do |format|
      format.turbo_stream
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to post_path(@post), status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.turbo_stream
        format.html { redirect_to post_path(@post), target: '_top', notice: 'Post was successfully destroyed.' }
      else
        format.html { redirect_to post_path(@post), notice: 'Bad' }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:author, :message, :post_id)
  end
end
