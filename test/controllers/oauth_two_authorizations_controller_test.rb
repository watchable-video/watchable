require 'test_helper'

class OauthTwoAuthorizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_oauth_two_authorization_url
    assert_response :found
  end

  test "should get save" do
    controller.session[:cloudkit_id] = "cloudkit_id"
    get new_oauth_two_authorization_url
  end

end
