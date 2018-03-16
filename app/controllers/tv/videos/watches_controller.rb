module Tv
  module Videos
    class WatchesController < Tv::BaseController
      include VideoScoped

      def create
        @video.mark_unwatched!
        render json: nil
      end

      def destroy
        @video.mark_watched!
        render json: nil
      end

    end
  end
end