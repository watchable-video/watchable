json.array! @results do |result|
  if result.class == VideoChannel
    json.partial! "tv/channels/channel", channel: result
  else
    json.partial! "tv/videos/video", video: result
  end
end
