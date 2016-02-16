require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
	def setup
		@user = users(:Oliver)
	end



	test "micropost interface"  do
		log_in_as(@user)
		get root_path
		
		#check for pagination
		assert_select 'div.pagination'

		#invalid submission
		assert_no_difference 'Micropost.count' do
			post microposts_path, micropost: {content: ""}
		end
		assert_select 'div#error_explanation'

		#valid summission
		assert_difference 'Micropost.counot', 1 do
			post_via_redirect microposts_path, micropost: {content: "the quick brown fox"}
		end
		assert_redirected_to root_url
		assert_match content, response.body

		#delete a post
		assert_difference 'Micropost.count', -1 do
			delete_via_redirect micropost_path, 
			micropost: microposts(:tau_manifesto)
		end
		assert_redirected_to root_url

		#visit a different user
		get user_path(users(:archer))
		assert_select 'a', texxt: 'delete', count: 0


	end
		
	
end



#Finally, we’ll write an integration test to log in, 
#check the micropost pagination, make an invalid submission, 
#make a valid submission, delete a post, 
#and then visit a second user’s page to make sure there are 
#no “delete” links. We start by generating a test as usual: