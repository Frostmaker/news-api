class Api::PostsController < ApplicationController
	http_basic_authenticate_with name: Rails.application.credentials.name, password: Rails.application.credentials.password, except: [:show, :index]
	before_action :set_post, only: %i[ show edit update destroy ]
	skip_before_action :verify_authenticity_token
  
	# GET api/posts.json
	def index
	  @posts = Post.all

	  respond_to do |format|
		format.json { render json: @posts }
	  end
	end
  
	# GET api/posts/1.json
	def show
  	  respond_to do |format|
		format.json { render json: @post }
	  end
	end
  
	
	# POST api/posts.json
	def create
	  @post = Post.new(post_params)
  
	  respond_to do |format|
		if @post.save
		  format.json { render :show, status: :created, location: @post }
		else
		  format.json { render json: @post.errors, status: :unprocessable_entity }
		end
	  end
	end
  
	# PATCH/PUT api/posts/1.json
	def update
	  respond_to do |format|
		if @post.update(post_params)
		  format.json { render :show, status: :ok, location: @post }
		else
		  format.json { render json: @post.errors, status: :unprocessable_entity }
		end
	  end
	end
  
	# DELETE api/posts/1.json
	def destroy
	  @post.destroy
  
	  respond_to do |format|
		format.json { redirect_to posts_path }
	  end
	end
  
	private
	  def set_post
		@post = Post.find(params[:id])
	  end
  
	  def post_params
		params.require(:post).permit(:title, :content)
	  end
  end
  