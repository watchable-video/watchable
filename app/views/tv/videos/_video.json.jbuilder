json.cache! video do
  json.subtitle "#{video.data["channel_title"]} - #{video.video_published_at.strftime("%B %e")}"
  json.timecode video.timecode
  json.full_date video.video_published_at.strftime("%B %e, %Y")
  json.extract! video, :id, :youtube_id, :progress, :watched, :data
end
