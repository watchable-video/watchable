require 'test_helper'
module Tv
  module Videos
    class WatchesControllerTest < ActionDispatch::IntegrationTest

      test "should mark watched" do
        video = videos(:one)
        assert_not video.reload.watched

        post tv_video_watch_path(video.id), params: {cloudkit_id: video[:cloudkit_id]}
        assert_response :success
        assert video.reload.watched
      end

    end
  end
end