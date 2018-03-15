json.cache! video_channel do
  json.type video_channel.class.name.downcase
  json.extract! video_channel, :id, :youtube_id, :poster_frame, :data
end
