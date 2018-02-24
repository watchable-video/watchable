class Tv::AppsController < Tv::BaseController

  def index
    redirect_to helpers.asset_url("tv.js")
  end

end
