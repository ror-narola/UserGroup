class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :join, :destroy]

  def index
    @section = params && params[:section].present? ? params[:section] : "all_groups"
    @groups  = if @section == "created_by_me"
                current_user.groups
              elsif @section == "all_groups"
                Group.order(created_at: :desc)
              else
                Group.member_groups(current_user)
              end
    @groups = @groups.includes(:group_members).order(created_at: :desc)
  end

  def new
    @group = Group.new
    render 'form', layout: false
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "Group created successfully"
      redirect_to groups_path
    end
  end

  def show
    @post = Post.new(group_id: @group.id)
    @posts = @group.posts
  end

  def edit
    render 'form', layout: false
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "Group created successfully"
      redirect_to group_path(@group)
    end
  end

  def destroy
    if @group.destroy
      flash[:notice] = "Group deleted successfully"
      redirect_to root_path
    end
  end

  def join_member
    @group = Group.find_by(id: params[:group_id])
    if @group.group_members.create(member_id: current_user.id)
      flash[:notice] = "Now, You are member of group '#{@group.owner.user_name}'"
      redirect_to group_path(@group)
    end
  end

  def remove_member
    @group = Group.find_by(id: params[:group_id])
    @group_member = @group.group_members.find_by(member_id: params[:member_id])
    if (@group.owner == current_user || @group_member.member == current_user) && @group_member.destroy
      flash[:notice] = "Group member removed successfully"
      redirect_to group_path(@group)
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def find_group
    @group = Group.find_by(id: params[:id])
  end
end
