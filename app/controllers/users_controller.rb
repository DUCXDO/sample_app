class UsersController < ApplicationController
  before_action :search_user, only: %i(edit show update destroy)
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.page(params[:page]).per Settings.page_limit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".remind_check_email"
      redirect_to root_url
    else
      flash.now[:danger] = t ".fail"
      render :new
    end
  end

  def show
    @microposts = @user.feed.page(params[:page]).per Settings.page_limit
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".edit_fail"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".user_deleted"
    redirect_to users_url
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def search_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "user_not_found"
    redirect_to home_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
