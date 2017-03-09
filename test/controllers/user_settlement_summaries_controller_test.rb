require 'test_helper'

class UserSettlementSummariesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_settlement_summaries_new_url
    assert_response :success
  end

end
