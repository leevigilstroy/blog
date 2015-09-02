require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user =  users(:Oliver)
  end
  
  test "invalid login details" do
    get login_path
    assert_template  'sessions/new'
    post login_path, session: {email: "", password: ""}
    assert_template 'sessions/new'
    assert_equal flash[:danger], "Invalid email/password combination"
  end
  
  test "valid log in details, followed by logout" do 
    get login_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    
    assert_template  'sessions/new'
    post login_path, session: {email: @user.email, password: 'password'}
    assert_redirected_to @user
        
        assert_select "a[href=?]", users_path, count: 1
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", logout_path, count: 1
        assert_select "a[href=?]", user_path(@user)

    
    #log out test
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!

  end
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end  
  
end
