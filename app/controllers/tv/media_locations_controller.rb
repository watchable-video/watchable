require "open3"

class Tv::MediaLocationsController < Tv::BaseController

  def new
    @location = system_call(params["youtube_id"])
  end

  private

    def system_call(url)
      cmd = ["youtube-dl", "-g", "-f", "22/18", url]
      Rails.logger.debug("Running: #{cmd.join(" ")}")
      Open3.capture2e(*cmd).first.strip
    end

end
