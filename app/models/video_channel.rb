class VideoChannel

  attr_accessor :id

  def initialize(data)
    @data = data
  end

  def youtube_id
    @data.id.channel_id
  end

  def data
    @data.to_h
  end

  def poster_frame
    @data.snippet.thumbnails.high.url
  end

  private

    def cache_key
      youtube_id
    end

end
