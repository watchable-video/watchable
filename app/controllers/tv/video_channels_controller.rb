class Tv::VideoChannelsController < Tv::BaseController

  def show
    google = GoogleClient.new(@account.cloudkit_id)
    video_channel = VideoChannel.new(google.channel(params[:id]))
    video_channel.id = (1000..1100).to_a.sample
    @videos = google.channel_videos(video_channel.uploads_playlist, 25, false).map do |data|
      Video.new_from_api(@account, data).tap do |video|
        video.id = (100_000_000_000..100_000_001_000).to_a.sample
      end
    end
  end

end
