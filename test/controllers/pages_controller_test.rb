require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get members" do
  	get members_path
	assert_response :success
        assert_select "title", "Members"
  end
end
