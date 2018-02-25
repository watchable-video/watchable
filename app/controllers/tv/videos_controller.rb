class Tv::VideosController < Tv::BaseController

  def index
    videos = []
    client.subscribed_channels.each do |channel|
      channel.videos.where(max_results: 10).each do |video|
        videos.push video
      end
    end
    videos.sort_by { |video| video.published_at }
  end

  private

    def client = Yt::Account.new access_token: account.google_access_token, refresh_token: account.google_refresh_token
    end

    def account
      Account.last
    end
end
