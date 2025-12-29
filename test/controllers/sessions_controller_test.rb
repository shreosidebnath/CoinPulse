require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get demo" do
    get sessions_demo_url
    assert_response :success
  end
end
