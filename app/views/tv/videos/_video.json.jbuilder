json.cache! video do
  json.subtitle "#{video.data["channel_title"]} - #{video.video_published_at.strftime("%B %e")}"
  json.extract! video, :id, :youtube_id, :progress, :watched, :data
end
