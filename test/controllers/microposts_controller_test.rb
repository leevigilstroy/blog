require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase

	def setup
		@micropost = microposts(:orange)
    	@user =  users(:archer)
  	end
	

	test "should redirect create when not logged in"  do
		assert_no_difference 'Micropost.count' do
			post :create, micropost: {content: "quick brown fox"}
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Micropost.count' do
			delete :destroy, id: @micropost 
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy for wrong micropost" do
		log_in_as(@user)
		assert_no_difference 'Micropost.count' do
			delete :destroy, id: microposts(:tau_manifesto)
		end
		assert_redirected_to root_url
	end

end

