require "test_helper"

class HoldingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get holdings_create_url
    assert_response :success
  end

  test "should get destroy" do
    get holdings_destroy_url
    assert_response :success
  end
end
