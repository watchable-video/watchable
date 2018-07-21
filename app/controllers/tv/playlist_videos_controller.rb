class Tv::PlaylistVideosController < Tv::BaseController

  def index
    google = GoogleClient.new(@account.cloudkit_id)
    ids = (100_000_000..100_100_000).to_a
    @response = google.channel_videos(params[:playlist_id], max_results: 25, full_data: false, page_token: params[:page_token])
    @videos = @response.items.map do |data|
      Video.new_from_api(@account, data).tap do |video|
        video.id = ids.sample
      end
    end
  end

end
