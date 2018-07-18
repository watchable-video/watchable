class DeleteVideoFileJob < ApplicationJob
  queue_as :default

  discard_on StandardError

  def perform
    Video.where(watched: true).find_each do |video|
      path = Rails.root.join(*["public", *video.file_path])

      if video.file_path.present? && File.exist?(path)
        FileUtils.rm(path)
      end
    end
  end

end
