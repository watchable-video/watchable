class VideoChannel

  attr_accessor :id

  def initialize(data)
    @data = data
  end

  def youtube_id
    youtube_id = @data.id
    if youtube_id.respond_to?(:channel_id)
      youtube_id = youtube_id.channel_id
    end
    youtube_id
  end

  def data
    @data.to_h
  end

  def poster_frame
    @data.snippet.thumbnails.high.url
  end

  def uploads_playlist
    @data.content_details.related_playlists.uploads
  end

  private

    def cache_key
      youtube_id
    end

end
