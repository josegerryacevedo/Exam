class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @post.comments.includes(:user)
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to post_comments_path(@post), notice: 'Comment was successfully submitted'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_comments_path(@post, @comment)
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_comments_path(@post), notice: 'Comment successfully deleted'
    end
  end

  private

  def set_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end
end
