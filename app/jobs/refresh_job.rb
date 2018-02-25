class RefreshJob < ApplicationJob
  queue_as :default

  attr_reader :account

  def perform(account_id)
    @account = Account.find(account_id)
    client.subscribed_channels.each do |channel|
      channel.videos.where(max_results: 3).includes(:content_details).each do |video|
        Video.create(build(video))
      end
    end
  end

  private

    def build(video)
      attributes = %I[title description duration view_count like_count channel_title]
      data = attributes.each_with_object({}) do |attribute, hash|
        hash[attribute] = video.send(attribute)
      end
      data[:hd] = video.hd?
      data[:thumbnail_url] = video.thumbnail_url(:high)

      {
        youtube_id: video.id,
        cloudkit_id: account.cloudkit_id,
        video_published_at: video.published_at,
        data: data
      }
    end

    def client
      Yt::Account.new access_token: account.google_access_token, refresh_token: account.google_refresh_token
    end

end
