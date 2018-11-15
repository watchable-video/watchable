class Tv::DownloadsController < Tv::BaseController

  skip_before_action :authorize

  def new
    DownloadVideoJob.perform_later(params[:url])
    render text: 'Download Started!'
  end

end

