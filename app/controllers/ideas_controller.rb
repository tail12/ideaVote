class IdeasController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  before_action :set_idea, except: [:new, :create, :detail]

  def new
    @idea = Idea.new
  end

  def show
    @user = @idea.user
    @users = @idea.liking_users
  end

  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      flash[:success] = "投稿完了"
      redirect_to root_url
    else
      # @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      render 'ideas/new'
    end
  end

  def detail
    @ideas = Idea.all.order("updated_at DESC").limit(6)
  end

  def liking_users
    @users = @idea.liking_users
  end

  private
  def idea_params
    params.require(:idea).permit(:idea_name, :content, :purpose, :remark, :picture)
  end
  def set_idea
    @idea = Idea.find(params[:id])
  end

end
