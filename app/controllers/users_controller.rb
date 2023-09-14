class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))

    @likes_count = current_user.liked_photos.count
    @posts_count = current_user.own_photos.count
    @followers_count = current_user.followers.count
    @following_count = current_user.following.count
  end
end
