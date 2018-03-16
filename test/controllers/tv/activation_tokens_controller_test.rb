require 'test_helper'

class Tv::ActivationTokensControllerTest < ActionDispatch::IntegrationTest

  test "should create activation token" do
    post tv_activation_tokens_path, params: {cloudkit_id: SecureRandom.hex}, as: :json
    assert_response :success
  end

end
