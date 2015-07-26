require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user =  User.new(id: 1, name: "Oliver", email:"oliver@email.com", password: "Nelsons", password_confirmation: "Nelsons")
    @other_user = users(:archer)
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert_redirected_to root_url
    assert flash.empty?
end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: {name: @user.name, email: @user.email}
    assert_redirected_to root_url
    assert flash.empty?    
  end
  
  test "Should redirect edit when not logged in" do
    get :edit, id: @user
    assert_redirected_to login_url
    assert_not flash.empty?
  end
  
  test "Should redirect update when not logged in" do
    patch  :update, id: @user, user: {name: @user.name, email: @user.email}
    assert_redirected_to login_url
    assert_not flash.empty?
  end
  
  test "User index page loads" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
    assert_template 'users/index'
  end
  
  test "show user" do
    get(:show , {id: 1})
    assert_response :success
    assert_template 'users/show'
    assert_not_nil assigns(:user)
   end
  
  test "Save new user" do
    assert_difference('User.count', 1) do
      post :create, user: {name: @user.name, email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation}
      end
   assert_redirected_to user_path(assigns(:user))
   assert_equal 'Welcome to my sample app!', flash[:success]
   
  end
  
  test "Update a user" do
    log_in_as(@user)
    patch  :update, id: @user, user: {name: "change title",  email: "changecontent@email.com", password: @user.password, password_confirmation: @user.password_confirmation}
    assert_redirected_to root_path
    assert_equal 'Profile Updated', flash[:success]    
  end

  test "delete user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.id
     end
    assert_redirected_to root_path
  end
  
  
end
