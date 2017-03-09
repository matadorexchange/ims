require 'test_helper'

class AgentCommissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get agent_commissions_new_url
    assert_response :success
  end

end
