require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end
  
  test "invalid login action" do
    get login_path
    assert_template 'sessions/new'

    post login_path, session: { email: "", password: "new-wrong-password"}
    assert_template 'sessions/new'
    assert_not flash.empty?

    get root_path
    assert flash.empty?, "Flash exist"
  end

  test "valid login action" do
    get login_path
    assert_template 'sessions/new'

    post login_path, session: {email: "test@example.com", password: "password"}
    assert is_logged_in?
    assert_redirected_to notes_path
    follow_redirect!
    assert_not flash.empty?
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path

    # Logout action test
    delete logout_path
    assert_redirected_to login_url
    # Simulate logout on a second window
    delete logout_path
    follow_redirect!
    assert_not flash.empty?
    assert_select 'a[href=?]', user_path(@user), count: 0
    assert_select 'a[href=?]', logout_path, count: 0
  end

  test "login with remember" do
    login_as(@user, remember_me: '1')
    assert_equal assigns(:user).authenticated?(cookies["remember_token"]), true
  end

  test "login without remember me" do
    login_as(@user, remember_me: '0')
    assert_nil cookies["remember_token"]
  end
end
