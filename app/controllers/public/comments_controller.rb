class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
    #   redirect_to post_path(@post.id)
  end

  def destroy
    # Comment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    # redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
