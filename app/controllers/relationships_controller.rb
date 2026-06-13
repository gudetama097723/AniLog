class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:followed_id])
    Current.user.follow(user)

    redirect_to user_path(user), notice: "#{user.name}さんをフォローしました"
  end

  def destroy
    relationship = Current.user.active_relationships.find(params[:id])
    user = relationship.followed
    relationship.destroy

    redirect_to user_path(user), notice: "#{user.name}さんのフォローを解除しました"
  end
end
