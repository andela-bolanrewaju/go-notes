class UsersController < ApplicationController
  layout 'application'
  before_action :logged_in_user, only: [:edit, :update] 
  before_action :correct_user, only: [:edit, :update] 

  def index
    redirect_to edit_user_path(current_user)
  end

  def new
    if logged_in?
      redirect_to notes_url
    end
    @user = User.new 
     render 'new', :layout => 'index'

  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Go-Notes #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      flash[:danger] = "Error: profile couldn't be updated. Please try again"
      render 'edit'
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
