require 'test_helper'

class MasterAgentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get master_agents_new_url
    assert_response :success
  end

end
