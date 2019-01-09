class FollowersController < ApplicationController
  before_action :logged_in_user

  def show
    @title = t ".followers_title"
    @user = User.find_by id: params[:id]
    @users = @user.followers.page(params[:page]).per Settings.page_limit
    render "users/show_follow"
  end
end
