class RefreshJob < ApplicationJob
  queue_as :default

  discard_on StandardError

  attr_reader :account, :client

  def perform(account)
    @account = account
    @client = GoogleClient.new(account.cloudkit_id)

    client.subscribed_playlist_ids.each do |playlist_id|
      create_and_update_videos(playlist_id)
    end
    account.update(initial_sync_complete: true)
  end

  def create_and_update_videos(playlist_id)
    videos = client.channel_videos(playlist_id).each_with_object([]) do |data, updates|
      video = Video.new_from_api(account, data)
      video.save!
    rescue ActiveRecord::RecordNotUnique
      updates.push video
    end
    Video.import videos, on_duplicate_key_update: {conflict_target: [:cloudkit_id, :youtube_id], columns: [:data]}
  end

end
