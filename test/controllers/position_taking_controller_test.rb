require 'test_helper'

class PositionTakingControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get position_taking_new_url
    assert_response :success
  end

end
