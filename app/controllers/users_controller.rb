class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # file = params[:user][:avatar]
    # @user.set_image(file)
    if @user.save
      log_in @user
      redirect_to @user, notice: "会員登録完了です！"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @ideas = @user.ideas
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      # file = params[:user][:avatar]
      # @user.set_image(file)
      flash[:success] = "更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def like_ideas
    @title = "お気に入りした投稿"
    @user = User.find(params[:id])
    @ideas = @user.like_ideas
    render 'show_ideas'
  end

  def following
    @title = "フォロー中のユーザ"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followed_users
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      redirect_to root_path, alert: 'アクセスが許可されていません！'
    end
  end
end
