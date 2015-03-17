require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "test", email: "test@testing.com", password: "testest", password_confirmation: "testest")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should be less than 20" do
    @user.name = "user" * 6
    assert_not @user.valid?
  end

  test "email should less than 255" do
    @user.email = "email" * 80 + "@testmail.com"
    assert_not @user.valid?
  end

  test "should only accept valid email addresses" do
    valid_addresses = %w[user@email.com USER@testmail.COM A_US-ER@new.email.org new.user@mail.cn mail+user@newmail.jp]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "should reject invalid email addresses" do
    invalid_addresses = %w[user@email,com new_user_email.com new.user@mail. mailuser@new+mail.jp]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be valid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be downcase before save" do
    temp_user = @user.dup
    temp_user.email = "tEsT@teSTInG.cOm"
    temp_user.save
    assert temp_user.email == @user.email
  end

  test "password should not be less than 6" do
    @user.password = @user.password_confirmation = "five"
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end
