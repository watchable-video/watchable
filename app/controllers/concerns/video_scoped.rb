module VideoScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_video
  end

  private
    def set_video
      @video = @account.videos.find(params[:video_id])
    end
end
