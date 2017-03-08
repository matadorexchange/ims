require 'test_helper'

class MarketControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get market_new_url
    assert_response :success
  end

end
