json.date video.video_published_at.strftime("%B %e")
json.extract! video, :youtube_id, :progress, :watched, :data
