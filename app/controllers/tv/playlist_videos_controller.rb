class Tv::PlaylistVideosController < Tv::BaseController

  def index
    google = GoogleClient.new(@account.cloudkit_id)
    @videos = google.channel_videos(params[:playlist_id], 25, false).map do |data|
      Video.new_from_api(@account, data).tap do |video|
        video.id = (100_000_000_000..100_000_001_000).to_a.sample
      end
    end
  end

end
