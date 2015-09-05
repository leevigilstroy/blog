require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user =  User.new(id: 1, name: "Oliver", email:"oliver@email.com", password: "Nelsons", password_confirmation: "Nelsons", admin: true, activated: true, activated_at: Time.zone.now)
    @other_user = users(:archer)
  end
  
  test "should redirect Index when not logged in" do
    get :index
    assert_redirected_to login_url
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
    log_in_as(@user)
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
   assert_redirected_to root_path
   assert_equal 'Please check your email to activate your account', flash[:info]
   
  end
  
  test "Update a user" do
    log_in_as(@user)
    patch  :update, id: @user, user: {name: "change title",  email: "changecontent@email.com", password: @user.password, password_confirmation: @user.password_confirmation}
    assert_redirected_to root_path
    assert_equal 'Profile Updated', flash[:success]    
  end
  
  test "cannot update a user admin status" do
    patch :update, id:@user.id, user: {admin: false}
    assert @user.admin? 
    
    log_in_as(@other_user)
    patch :update, id: @other_user, user: {admin: true}
    assert_not @other_user.admin? 
  end
  

  
  test "should redirect destroy request when not logged in" do
     assert_no_difference('User.count') do
       delete :destroy, id: @user
     end
     assert_redirected_to login_url
   end
  
  test "should redirect destroy request when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference('User.count') do
      delete :destroy, id: @user.id
    end
    assert_redirected_to users_path
  end
  
end
