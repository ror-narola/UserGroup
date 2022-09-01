class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_post
  before_action :set_comment, except: :create

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comments added successfully"
      redirect_to group_post_comments_path(@comment.post)
    end
  end

  def edit
    render '_form', layout: false
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated successfully"
      redirect_to group_post_path(@group, @comment.post)
    end
  end

  def destroy
    if (@comment.user == current_user || @comment.post.user == current_user) && @comment.destroy
      flash[:notice] = "Comment deleted successfully"
    end
    redirect_to group_post_path(@group, @comment.post)
  end

  def reply
    parent = @post.comments.find_by(id: params[:comment_id])
    @comment = @post.comments.new(reply_of_id: parent.id, post_id: parent.post_id)
    render '_form', layout: false
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :reply_of_id)
  end

  def set_group
    @group = Group.find_by(id: params[:group_id])
  end

  def set_post
    @post = @group.posts.find_by(id: params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find_by(id: params[:id])
  end
end
