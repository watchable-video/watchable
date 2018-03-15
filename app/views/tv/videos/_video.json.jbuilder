json.cache! video do
  json.type video.class.name.downcase
  json.subtitle "Posted by #{video.data["snippet"]["channel_title"]} on #{video.video_published_at.strftime("%B %e, %Y")}"
  json.full_date video.video_published_at.strftime("%B %e, %Y")
  json.extract! video, :id, :youtube_id, :watched, :duration_in_seconds, :poster_frame, :hd, :data, :read_only
end
