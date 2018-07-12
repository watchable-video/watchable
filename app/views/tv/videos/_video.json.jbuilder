json.cache! video do
  json.type video.class.name.downcase
  json.full_date video.video_published_at.strftime("%B %e, %Y")
  json.video_file_url video.video_file_url
  json.extract! video, :id, :youtube_id, :title, :subtitle, :watched, :duration_in_seconds, :poster_frame, :hd, :data, :read_only
end
