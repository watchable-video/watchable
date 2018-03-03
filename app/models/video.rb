class Video < ApplicationRecord

  def timecode
    Time.at(data["duration"]).utc.strftime("%H:%M:%S")
  end

end
