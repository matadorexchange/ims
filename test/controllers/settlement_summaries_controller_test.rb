require 'test_helper'

class SettlementSummariesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get settlement_summaries_new_url
    assert_response :success
  end

end
