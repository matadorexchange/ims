require 'test_helper'

class SettlementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get settlements_new_url
    assert_response :success
  end

end
