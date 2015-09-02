require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:Oliver)
    @non_admin = users(:archer)
  end
  
  
  test "index page pagination and delete as admin only" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page:1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text:'Delete'
      end
    end 
    assert_difference('User.count',-1) do
       delete user_path(@non_admin)
      assert_equal 'User Deleted', flash[:success]
    end
    assert_redirected_to users_path
  end
  
  test "index page as non-admin user" do
    log_in_as(@non_admin)
    get users_path
    assert_template 'users/index'
    assert_select 'a', text:"Delete", count: 0
  end
end
