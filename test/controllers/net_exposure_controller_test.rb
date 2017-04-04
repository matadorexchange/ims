require 'test_helper'

class NetExposureControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get net_exposure_new_url
    assert_response :success
  end

end
