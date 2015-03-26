require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:test)
    @user2 = users(:test2)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should hit edit and redirect when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should hit update and redirect when not logged in" do
    patch :update, id: @user, user: { email: @user.email, name: @user.name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect if not right user to edit" do
    login_as(@user)
    get :edit, id: @user2
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect if not right user to update" do
    login_as(@user2)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
