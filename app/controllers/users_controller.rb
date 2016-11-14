class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
      flash[:success] = "更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def like_ideas
  end



  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
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
