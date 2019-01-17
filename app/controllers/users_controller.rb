class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash.now[:success] = t ".welcome"
      redirect_to @user
    else
      flash.now[:fail] = t ".fail"
      render :new
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
