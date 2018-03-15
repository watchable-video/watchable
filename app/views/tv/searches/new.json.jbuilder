json.array! @results do |result|
  if result.class == VideoChannel
    json.partial! "tv/video_channels/video_channel", video_channel: result
  else
    json.partial! "tv/videos/video", video: result
  end
end
