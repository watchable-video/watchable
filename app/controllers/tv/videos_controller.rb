class Tv::VideosController < Tv::BaseController

  def index
    @videos = @account.videos.where(watched: false).order(video_published_at: :desc).with_attached_video_file().limit(100)
  end

end
