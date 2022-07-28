class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
  @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_posts_path, notice: 'Successfully Submitted'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_posts_path, notice: 'Successfully Submitted'
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_posts_path, notice: 'Successfully Deleted'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def check_admin
    unless current_user.admin?
      flash[:notice] = "You do not have permission"
      redirect_to posts_path
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
