class Tv::DownloadsController < Tv::BaseController

  skip_before_action :authorize

  def new
    DownloadVideoJob.perform_later(params[:url])
    render plain: 'Download started!'
  end

end

