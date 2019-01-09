class PasswordResetsController < ApplicationController
  before_action :search_user, :valid_user, :check_expiration,
    only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".email_reset_send"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".not_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t ".reset_succesful"
      redirect_to @user
    else
      render :edit
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t ".expired"
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  private

  def search_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    return if @user&.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end
end
