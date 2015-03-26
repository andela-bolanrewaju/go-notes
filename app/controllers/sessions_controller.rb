class SessionsController < ApplicationController
  layout 'index'
  
  def new
    redirect_to notes_url if logged_in?
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = "You have successfully logged in"
      redirect_back_or notes_url
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "You have successfully logged out" 
    redirect_to login_url
  end


end
