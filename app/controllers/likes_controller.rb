class LikesController < ApplicationController
  def like
    @idea = Idea.find(params[:idea_id])
    @users = @idea.liking_users.order("updated_at DESC").limit(6)
    like = current_user.likes.build(idea_id: @idea.id)
    like.save
  end

  def unlike
    @idea = Idea.find(params[:idea_id])
    @users = @idea.liking_users.order("updated_at DESC").limit(6)
    like = current_user.likes.find_by(idea_id: @idea.id)
    like.destroy
  end
end
