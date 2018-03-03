module Tv
  module Videos
    class WatchesController < Tv::BaseController
      include VideoScoped

      def create
        @video.mark_watched!
        render json: nil
      end

    end
  end
end