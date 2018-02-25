class Tv::VideosController < Tv::BaseController

  def index
    @videos = @account.videos.order(video_published_at: :desc).limit(100)
  end

end
