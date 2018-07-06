class DeleteVideoFileJob < ApplicationJob
  queue_as :default

  discard_on StandardError

  def perform
    Video.where(watched: true).find_each do |video|
      video.video_file.attached? && video.video_file.purge
    end
  end

end
