class WelcomeController < ApplicationController
  def index
    @ideas = Idea.all.order("updated_at DESC").limit(30)
  end
end
