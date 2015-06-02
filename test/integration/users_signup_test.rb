require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    @user =  User.new(name: "Oliver", email:"oliver@email.com", password: "Nelsons", password_confirmation: "Nelsons", id: 1)
  end
  
  
  test "Successful User Sign up" do
    assert_difference('User.count',1) do
      get signup_path
      post_via_redirect users_path, user: {name: @user.name, email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation}
    end
    assert_equal 'Welcome to my sample app!', flash[:success]
    assert_template 'users/show'
    assert is_logged_in?
  end
  
  test "unsuccessful User Sign up" do
    assert_difference('User.count',0) do
      get signup_path
      post users_path, user: {name: "", email: "", password: @user.password, password_confirmation: "1234564567"}
    end
    assert_template 'users/new'
  end
  
end
