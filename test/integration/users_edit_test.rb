require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Oliver)
  end
  
  test "successful user edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_redirected_to login_path
    assert_not_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Foo Bar"
    email = "foobar@email.com"
    patch user_path(@user), user: {name: name, email: email}
    assert_not flash.empty?
    assert_redirected_to root_path

    delete logout_path
    assert_not is_logged_in?
    assert_nil session[:forwarding_url]

    
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    

    
  end
  
  
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {
      name: "",
      email: "email@invalid",
      password: "foo",
      password_confirmation: "bar"}
    assert_template 'users/edit'
  end
  
  test "successful user edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: {
      name: name,
      email: email,
      password: "",
      password_confirmation: ""}
    assert_not flash.empty?
    assert_redirected_to root_path
    #test user details updated
    @user.reload
    assert_equal email, @user.email
    assert_equal name, @user.name
  end
      
end
