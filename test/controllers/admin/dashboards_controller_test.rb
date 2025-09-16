require "test_helper"

class Admin::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get admin_dashboards_dashboard_url
    assert_response :success
  end
end
