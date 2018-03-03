class Video < ApplicationRecord

  def timecode
    Time.at(data["duration"]).utc.strftime("%H:%M:%S")
  end

  def mark_watched
    self.update(watched: true)
  end

end
