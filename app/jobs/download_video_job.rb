class DownloadVideoJob < ApplicationJob
  queue_as :default

  attr_reader :url

  def perform(url)
    @url = url
    if source_path = download
      FileUtils.mkdir_p File.dirname(full_destination_path)
      File.rename source_path, full_destination_path
      file_url = URI.join(Rails.application.secrets.default_host, destination_path.join("/")).to_s
      email(file_url)
    end
  end

  private

    def filename
      Digest::SHA1.hexdigest(url).ext("mp4")
    end

    def destination_path
      ["videos", filename]
    end

    def full_destination_path
      Rails.root.join(*["public", *destination_path])
    end

    def download
      filename = "#{SecureRandom.hex}.mkv"
      path = File.join("/", "tmp", filename)
      command = [
        "youtube-dl",
        "--quiet",
        "--format",
        "'bestvideo+bestaudio'",
        "--merge-output-format",
        "mkv",
        "--output",
        "#{path}",
        url
      ]

      if system(command.join(" ")) && File.exist?(path)
        path
      else
        nil
      end
    end

    def email(file_url)
      command="#{ENV['EMAIL_COMMAND']}'vlc-x-callback://x-callback-url/stream?url=#{file_url}'"
      system(command)
    end

end
