json.cache! channel do
  json.type channel.class.name.downcase
  json.extract! channel, :id, :youtube_id, :poster_frame, :data
end
