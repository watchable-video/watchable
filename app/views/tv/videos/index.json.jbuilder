json.cache! @videos do
  json.partial! "tv/videos/video", collection: @videos, as: :video
end
