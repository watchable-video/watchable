class RefreshJob < ApplicationJob
  queue_as :default

  attr_reader :account

  discard_on StandardError

  def perform(account)
    google = GoogleClient.new(account.cloudkit_id)
    playlist_ids = google.subscribed_playlist_ids
    playlist_ids.each do |playlist_id|
      videos = google.channel_videos(playlist_id).map do |data|
        Video.new_from_api(account, data)
      end
      Video.import videos, on_duplicate_key_update: {conflict_target: [:cloudkit_id, :youtube_id], columns: [:data]}
    end
  end

end
