require 'test_helper'

class MasterAgentControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get master_agent_new_url
    assert_response :success
  end

end
