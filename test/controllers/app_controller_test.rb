require 'test_helper'

class Tv::AppControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get tv_app_url
    assert_response :found
  end

end
