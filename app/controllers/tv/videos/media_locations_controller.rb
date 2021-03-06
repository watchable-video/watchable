class Tv::Videos::MediaLocationsController < Tv::BaseController

  def show
    video = @account.videos.find(params[:video_id])
    @location = youtube_dl_api_request(video.youtube_id)
  end

  private

    def youtube_dl_api_request(youtube_id)
      params = { video: youtube_id }

      uri = URI Rails.application.secrets.ytdl_url
      uri.path = "/info"
      uri.query = URI.encode_www_form params

      response = Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new uri
        http.request request
      end

      data = JSON.load(response.body)

      data["url"]
    end

end
