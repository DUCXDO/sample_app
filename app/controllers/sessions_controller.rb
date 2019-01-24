class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      login_advance user
    else
      flash.now[:danger] = t ".wrong"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_advance user
    if user.activated?
      log_in user

      if params[:session][:remember_me] == Settings.its_true
        remember user
      else
        forget user
      end
      flash[:success] = t ".success_login"
      redirect_back_or user
    else
      flash[:warning] = t ".message"
      redirect_to root_url
    end
  end
end
