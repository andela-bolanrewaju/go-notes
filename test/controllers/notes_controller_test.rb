require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  #test file for notes controller
  def setup
    @user = users(:test)
    @note = @user.notes.create!(content: "Test content", category: "uncategorized")
  end
  
  test "should redirect if user not logged in" do
    get :show
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should render notes if user is logged" do
    login_as(@user)
    get :show
    assert_template 'notes/show'
    assert flash.empty?
  end

  test "new note should redirect if user is not logged in" do
    get :new
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "renders new if user is logged in" do
    login_as(@user)
    get :new
    assert_template 'notes/_notesform'
    assert flash.empty?
  end

end
