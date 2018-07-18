class ProcessVideoJob < ApplicationJob
  queue_as :default

  attr_reader :video

  def perform(video)
    @video = video

    if source_path = download
      FileUtils.mkdir_p File.dirname(full_destination_path)

      File.rename source_path, full_destination_path

      video.update file_path: destination_path
    end
  end

  private

    def filename
      Digest::SHA1.hexdigest(video.youtube_id).ext("mp4")
    end

    def destination_path
      ["videos", filename]
    end

    def full_destination_path
      Rails.root.join(*["public", *destination_path])
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
