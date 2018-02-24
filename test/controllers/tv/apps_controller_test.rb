require 'test_helper'

module Tv
  class AppsControllerTest < ActionDispatch::IntegrationTest

    test "should get index" do
      get tv_apps_url
      assert_response :success
    end

  end
end
