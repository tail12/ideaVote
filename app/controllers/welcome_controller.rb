class WelcomeController < ApplicationController
  def index
    if logged_in?
      @idea = current_user.ideas.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).limit(6)
    end
  end
end
