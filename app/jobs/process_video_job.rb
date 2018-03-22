class ProcessVideoJob < ApplicationJob
  queue_as :default

  attr_reader :video

  def perform(video)
    @video = video

    if path = download
      video.video_file.attach io: File.open(path), filename: "video.mp4", content_type: "video/mp4"
      FileUtils.rm(path)
    end
  end

  def download
    filename = "#{SecureRandom.hex}.mp4"
    path = File.join("/", "tmp", filename)
    command = [
      "youtube-dl",
      "--quiet",
      "--format",
      "'bestvideo[height<=?1080][ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio'",
      "--merge-output-format",
      "mp4",
      "--output",
      "#{path}",
      "#{video.youtube_id}",
    ]

    if system(command.join(" ")) && File.exist?(path)
      path
    else
      nil
    end
  end

end
