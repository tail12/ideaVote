class WelcomeController < ApplicationController
  def index
    @ideas = Idea.all.order("updated_at DESC").limit(6)
    if logged_in?
      @idea = current_user.ideas.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).limit(6)
    end
  end
end
