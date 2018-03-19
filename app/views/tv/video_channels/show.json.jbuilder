json.partial! "tv/video_channels/video_channel", video_channel: @video_channel
json.videos @videos, partial: 'tv/videos/video', as: :video
