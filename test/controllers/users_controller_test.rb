require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:one)
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
      post :create, user: {name: "abcdt", email: "email@email.com"}
     assert_redirected_to user_path(assigns(:user))
    end
    assert_not_nil assigns(:user)
    assert_template 'users/show'
  end
  
  test "Update a user" do
    patch  :update, id: @user, user: {name: "change title",  email: "changecontent"}
    assert_redirected_to root_path
    assert_equal 'Details Updated', flash[:success]
    assert_template 'users/index'
    
  end

  test "delete user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.id
     end
    assert_redirected_to root_path
  end
  
  
end
