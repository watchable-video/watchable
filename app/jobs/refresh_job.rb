class RefreshJob < ApplicationJob
  queue_as :default

  attr_reader :account

  def perform(account)
    @account = account
    client.subscribed_channels.each do |channel|
      videos = channel.videos.where(max_results: 3).includes(:content_details).map do |data|
        Video.new_from_yt(account, data)
      end
      Video.import videos, on_duplicate_key_update: {conflict_target: [:cloudkit_id, :youtube_id], columns: [:data]}
    end
  end

  private

    def client
      Yt::Account.new access_token: account.google_access_token, refresh_token: account.google_refresh_token
    end

end
