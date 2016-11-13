class IdeasController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def new
    @idea = Idea.new
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      flash[:success] = "投稿完了"
      redirect_to root_url
    else
      render 'ideas/new'
    end
  end

  private
  def idea_params
    params.require(:idea).permit(:idea_name, :content, :purpose, :remark, :picture)
  end
end
