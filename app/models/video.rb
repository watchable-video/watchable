class Video < ApplicationRecord

  after_create_commit :process_video_file

  has_one_attached :video_file

  def self.new_from_api(account, data)
    youtube_id = data.id
    if youtube_id.respond_to?(:video_id)
      youtube_id = youtube_id.video_id
    end
    Video.new(
      youtube_id: youtube_id,
      cloudkit_id: account.cloudkit_id,
      video_published_at: data.snippet.published_at,
      data: data.to_h
    )
  end

  def mark_watched!
    self.update(watched: true)
  end

  def mark_unwatched!
    self.update(watched: false)
  end

  def duration_in_seconds
    if duration = data.dig("content_details", "duration")
      match = duration.match %r{^P(?:|(?<weeks>\d*?)W)(?:|(?<days>\d*?)D)(?:|T(?:|(?<hours>\d*?)H)(?:|(?<min>\d*?)M)(?:|(?<sec>\d*?)S))$}
      weeks = (match[:weeks] || '0').to_i
      days = (match[:days] || '0').to_i
      hours = (match[:hours] || '0').to_i
      minutes = (match[:min] || '0').to_i
      seconds = (match[:sec]).to_i
      (((((weeks * 7) + days) * 24 + hours) * 60) + minutes) * 60 + seconds
    end
  end

  def poster_frame
    if thumbnails = data.dig("snippet", "thumbnails",)
      thumbnails.dig("maxres", "url") ||  thumbnails.dig("standard", "url") ||  thumbnails.dig("high", "url")
    end
  end

  def hd
    data.dig("content_details", "definition") == "hd"
  end

  def read_only
    new_record?
  end

  def video_file_url
    if persisted? && video_file.attached?
      video_file.service_url(expires_in: 1.week)
    end
  end

  def title
    parsed_title.title
  end

  def subtitle
    parsed_title.subtitle
  end

  private

    def parsed_title
      @parsed_title ||= ParsedTitle.new(video_metadata.dig("title"), video_metadata.dig("channel_title"))
    end

    def video_metadata
      self.data.dig("snippet")
    end

    def cache_key
      if persisted?
        super
      else
        youtube_id
      end
    end

    def process_video_file
      ProcessVideoJob.perform_later self
    end

end
