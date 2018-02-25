class RefreshJob < ApplicationJob
  queue_as :default

  attr_reader :account

  def perform(account_id)
    @account = Account.find(account_id)
    client.subscribed_channels.each do |channel|
      videos = channel.videos.where(max_results: 3).includes(:content_details).map do |data|
        build_video(data)
      end
      Video.import videos, on_duplicate_key_update: {conflict_target: [:cloudkit_id, :youtube_id], columns: [:data]}
    end
  end

  private

    def build_video(data)
      Video.new(
        youtube_id: data.id,
        cloudkit_id: account.cloudkit_id,
        video_published_at: data.published_at,
        data: build_data(data)
      )
    end

    def build_data(video)
      attributes = %I[title description duration view_count like_count channel_title]
      Hash.new.tap do |hash|
        attributes.each do |attribute|
          hash[attribute] = video.send(attribute)
        end
        hash[:hd] = video.hd?
        hash[:thumbnail_url] = image_url(video.thumbnail_url(:high))
      end
    end

    def client
      Yt::Account.new access_token: account.google_access_token, refresh_token: account.google_refresh_token
    end

    def image_url(url)
      max_url = url.sub("hqdefault", "maxresdefault")
      image_exists?(max_url) ? max_url : url
    end

    def image_exists?(url)
      url = URI.parse(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Head.new(url.request_uri)
      response = http.request(request)
      response.code == "200"
    end

end
