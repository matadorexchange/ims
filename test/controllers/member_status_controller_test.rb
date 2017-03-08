require 'test_helper'

class MemberStatusControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get member_status_new_url
    assert_response :success
  end

end
