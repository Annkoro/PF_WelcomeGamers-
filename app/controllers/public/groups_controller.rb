class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def join
    @group = Group.find(params[:id])
    # @group.usersにcurrent_userを追加する
    @group.users << current_user
    redirect_to groups_path
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path, notice: "新規グループが作成されました。"
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "編集内容が更新されました。"
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    # ユーザーの退会機能
    # @group.users.delete(current_user)
    redirect_to groups_path, notice: "グループが削除されました。"
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
