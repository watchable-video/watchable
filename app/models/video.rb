class Video < ApplicationRecord

  def self.new_from_yt(account, data)
    Video.new(
      youtube_id: data.id,
      cloudkit_id: account.cloudkit_id,
      video_published_at: data.published_at,
      data: build_data(data)
    )
  end

  def timecode
    Time.at(data["duration"]).utc.strftime("%H:%M:%S")
  end

  def mark_watched!
    self.update(watched: true)
  end

  private

    def self.build_data(video)
      attributes = %I[duration title channel_title]
      Hash.new.tap do |hash|
        attributes.each do |attribute|
          hash[attribute] = video.send(attribute)
        end
      end
    end

    def self.image_url(url)
      max_url = url.sub("hqdefault", "maxresdefault")
      image_exists?(max_url) ? max_url : url
    end

    def self.image_exists?(url)
      Rails.cache.fetch("image_exists/#{Digest::SHA1.hexdigest(url)}") do
        url = URI.parse(url)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Head.new(url.request_uri)
        response = http.request(request)
        response.code == "200"
      end
    end

    def cache_key
      if persisted?
        super
      else
        youtube_id
      end
    end

end
