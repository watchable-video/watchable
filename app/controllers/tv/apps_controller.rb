class Tv::AppsController < Tv::BaseController

  skip_before_action :authorize

  def index
    redirect_to helpers.asset_url("tv.js")
  end

end
