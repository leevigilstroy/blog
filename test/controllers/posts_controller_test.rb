require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  
  def setup
    @post = posts(:one)
  end
  
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
    assert_template :show
  end
  
  test "Save new post" do
    assert_difference('Post.count', 1) do
      post :create, post: {title: "test title", content: "Ipsofactum hoopity hoop"}
     end
    assert_redirected_to post_path(assigns(:post))
    assert_not_nil assigns(:post)
  end
  
  test "Update a post" do
    patch  :update, id: @post, post: {title: "change title",  contet: "change content"}
    assert_redirected_to post_path(assigns(:post))
  end

  test "delete post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.id
      assert_redirected_to root_path
    end
  end
  
   
  
  
end
