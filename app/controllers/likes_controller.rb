class LikesController < ApplicationController
  def like
    idea = Idea.find(params[:idea_id])
    like = current_user.likes.build(idea_id: idea.id)
    like.save
    redirect_to root_url
  end

  def unlike
    idea = Idea.find(params[:idea_id])
    like = current_user.likes.find_by(idea_id: idea.id)
    like.destroy
    redirect_to root_url
  end
end
