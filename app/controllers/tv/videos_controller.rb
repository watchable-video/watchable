class Tv::VideosController < Tv::BaseController

  before_action :load_record, only: [:mark_watched]

  def index
    @videos = @account.videos.where(watched: false).order(video_published_at: :desc).limit(100)
  end

  def mark_watched
    @video.mark_watched
    render json: nil
  end

  private

  def load_record
    @video = @account.videos.find(params[:id])
  end
end
