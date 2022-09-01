class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_post, except: :create

  def show
    @comment = @post.comments.new
    @comments = @post.comments.where(reply_of_id: nil)
  end

  def create
    @post = @group.posts.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post created successfully"
      redirect_to group_path(@post.group)
    end
  end

  def edit
    render '_form', layout: false
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully"
      redirect_to group_path(@group)
    end
  end

  def destroy
    if @post.user == current_user && @post.destroy
      flash[:notice] = "Post deleted successfully"
      redirect_to group_path(@post.group)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :group_id)
  end

  def set_group
    @group = Group.find_by(id: params[:group_id])
  end

  def set_post
    @post = @group.posts.find_by(id: params[:id])
  end
end
