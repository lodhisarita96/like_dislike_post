class PostsController < ApplicationController 
  before_action :set_post, only: %i[ show edit update destroy ]
 
    def index
      @posts = Post.all.order(cached_votes_score: :desc)
    end
  
    def upvote
      @post = Post.find(params[:id])
      if current_user.voted_up_on? @post
        @post.unvote_by current_user
      else
        @post.upvote_by current_user
      end
      render "vote.js.erb"
    end
  
    def downvote
      @post = Post.find(params[:id])
      if current_user.voted_down_on? @post
        @post.unvote_by current_user
      else
        @post.downvote_by current_user
      end
      render "vote.js.erb"
    end
  
    def show
    end
  
    def new
      @post = Post.new
    end
  
    def edit
    end
  
    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to @post, notice: "Post was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.update(post_params)
        redirect_to @post, notice: "Post was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post.destroy
      redirect_to posts_url, notice: "Post was successfully destroyed."
    end
  
    private
      def set_post
        @post = Post.find(params[:id])
      end
  
      def post_params
        params.require(:post).permit(:name)
      end
  end
  