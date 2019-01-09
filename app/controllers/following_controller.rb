class FollowingController < ApplicationController
  before_action :logged_in_user

  def show
    @title = t ".following_title"
    @user = User.find_by id: params[:id]
    @users = @user.following.page(params[:page]).per Settings.page_limit
    render "users/show_follow"
  end
end
