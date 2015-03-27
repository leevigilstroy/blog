require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  #  test "test root path" do
#    get :root
#    assert_template 'posts/index'
#  end
  
  test "Post index page loads" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
    assert_template 'posts/index'
  end
  
  test "show post" do
    get(:show , {id: 1})
    assert_response :success
    assert_not_nil assigns(:post)
   
  end
  
  test "Save new post" do
    assert_difference('Post.count') do
      post :create, post: {title: "test title", content: "Ipsofactum hoopity hoop"}
      end
    assert_redirected_to post_path(assigns(:post))
    assert_template :show
    assert_not_nil assigns(:post)
  end
  
  
   
  
  
end
