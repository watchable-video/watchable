require 'test_helper'

class Tv::VideosControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    video = videos(:one)
    get "/tv/videos.json", params: {cloudkit_id: video[:cloudkit_id]}
    assert_response :success
  end

end
