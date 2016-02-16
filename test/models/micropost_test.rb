require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

	def setup
		@user = users(:Oliver)
		@micropost = @user.microposts.build(content: "Quick brown fox")
	end

	test "micropost should be valid" do
		assert @micropost.valid?
	end

	test "user id should be present" do
		@micropost.user_id = nil
		assert_not @micropost.valid?
	end

	test "content shoudl be present" do
		@micropost.content = ""
		assert_not @micropost.valid?
	end

	test "content should be 140 characters maximum" do
		@micropost.content = "a"*141
		assert_not @micropost.valid?

	end

	test "order should be most recent first" do 
		assert_equal microposts(:most_recent), Micropost.first
	end








end
