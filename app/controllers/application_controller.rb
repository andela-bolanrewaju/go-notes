class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout 'index'
  protect_from_forgery with: :exception
  include SessionsHelper

  def home
  end

  def index
    if logged_in?
      redirect_to notes_url
    else
      render 'layouts/homepage'
    end
  end

  private
  # Before filters
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in to continue"
      redirect_to login_url
    end
  end
end
