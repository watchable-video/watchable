require 'test_helper'

class Tv::AppsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get tv_apps_url
    assert_response :found
  end

end
