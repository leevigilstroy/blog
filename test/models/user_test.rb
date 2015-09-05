require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user =  User.new(name: "Oliver", email:"oliver@email.com", password: "Nelsons", password_confirmation: "Nelsons")
  end
  
  test "user details should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 101 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email should accept valid email" do 
    valid_address= %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_address.each do |va|
      @user.email = va
      assert @user.valid? "#{va.inspect} should be valid"
    end
  end
  
  test "email should reject invalid email" do
     invalid_address = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_address.each do |iv|
      @user.email = iv
      assert_not @user.valid? "#{iv.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password length" do 
    @user.password = @user.password_confirmation = "abc"
    assert_not @user.valid?
  end
  
  test "downcase of email successfule" do
    @user.email = "OLIVER@EMAIL.COM"
    @user.save
    assert_not_equal "OLIVER@EMAIL.COM", @user.reload.email
  end
  
   test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
end
