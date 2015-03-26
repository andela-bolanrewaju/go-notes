require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end

  test "unsuccesful edit" do
    login_as(@user)
    assert is_logged_in?
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {email: "test@example.com",
                                        name: "",
                                        password: "password",
                                        password_confirmation: "password"}
    assert_template 'users/edit'
  end

  test "succesful edit" do
    login_as(@user)
    assert is_logged_in?
    get edit_user_path(@user)
    name = "Test"
    email = "newtest@example.com"
    assert_template 'users/edit'
    patch user_path(@user), user: {email: email,
                                        name: name,
                                        password: "",
                                        password_confirmation: ""}
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_equal @user.name, "Test"
    assert_equal @user.email, "newtest@example.com"
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    login_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "New User"
    email = "newuser@email.com"
    patch user_path(@user), user: {email: email,
                                        name: name,
                                        password: "newPassword",
                                        password_confirmation: "newPassword"}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
