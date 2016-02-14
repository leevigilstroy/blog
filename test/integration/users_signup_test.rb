require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  
  test "Successful User Sign up with account activation" do
    assert_difference('User.count',1) do
      get signup_path
      post users_path, user: {name: "testname", email: "test@email.com", password: "password", password_confirmation: "password"}
     assert_equal 'Please check your email to activate your account', flash[:info]
    end
    # line below verifies that exactly one email was sent
    assert_equal 1, ActionMailer::Base.deliveries.size
    #
    
    user = assigns(:user)
    assert_not user.activated?
    assert_redirected_to root_path
    assert_not is_logged_in?

    #try to log in before account activation
    log_in_as(user)
    assert_redirected_to root_path
    assert_equal 'Account not activated.  Check your email to activate your account', flash[:warning]
    assert_not is_logged_in?
    
    #invalid activation token
    get edit_account_activation_path("Invalidtoken")
    assert_not is_logged_in?
    assert_redirected_to root_path
    assert_equal 'Invalid activation link', flash[:danger]
    
    #valid token wrong email
    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?
    assert_redirected_to root_path
    assert_equal 'Invalid activation link', flash[:danger]
    
     # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert_equal true, user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
      
  end
  
  test "unsuccessful User Sign up" do
    assert_difference('User.count',0) do
      get signup_path
      post users_path, user: {name: "", email: "", password: "abccdefg", password_confirmation: "1234564567"}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
end
