require 'test_helper'

class NotesIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test)
  end

  test "should create a note" do
    login_as(@user)
    get notes_new_path
    assert_template 'notes/_notesform'
    assert_difference 'Note.count', 1 do
      post_via_redirect notes_new_path, note: { content: "A test entry", 
                                                category: "uncategorized"}
    end
    # follow_redirect!
    puts flash.inspect
    # assert_redirected_to 'notes/show'
  end

  test "should not create note if note is invalid" do
    login_as(@user)
    get notes_new_path
    assert_template 'notes/_notesform'
    assert_difference 'Note.count', 0 do
      post_via_redirect notes_new_path, note: { content: "", category: 'new cat'}
    end
    assert_template 'notes/_notesform'
  end
end