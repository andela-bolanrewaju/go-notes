require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:test)
    @note = @user.notes.build(content: "This is my content", category: "random")
  end

  test "Note is valid" do
    assert @note.valid?
  end

  test "user id to be present" do
    @note.user_id = nil
    assert_not @note.valid?
  end

  test "presence of content" do
    @note.content = " "
    assert_not @note.valid?
  end

  test "it should order by most recent" do
    assert_equal Note.first, notes(:most_recent)
  end
end
