class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: :show
  before_action :set_own_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.includes(:user)
    @domain = request.base_url
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully submitted'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: 'Post successfully deleted'
    end
  end

  def redirect
    @short_num = params[:short_url]
    @post = Post.find_by(short_url: @short_num)
    if @post.nil?
      not_found
    else
      redirect_to post_path (@post)
    end
  end

  private

  def set_own_post
    @post = current_user.posts.find_by_id(params[:id])
    if @post.nil?
      flash[:alert] = 'This post not belongs to you'
      redirect_to posts_path
    end
  end

  #Connected it to "Create"
  def post_params
    params.require(:post).permit(:title, :content, :address, :category_id)
  end

  #Connected it to "Show id"
  def set_post
    @post = Post.find(params[:id])
  end

end
