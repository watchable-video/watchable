class Tv::PlaylistsController < Tv::BaseController

  def show
    google = GoogleClient.new(@account.cloudkit_id)
    render json: google.channel_playlists(params[:id])
  end

end
