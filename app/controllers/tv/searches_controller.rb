class Tv::SearchesController < Tv::BaseController

  def new
    # ,channel,playlist
    google = GoogleClient.new(@account.cloudkit_id)
    response = google.client.list_searches('snippet', max_results: 25, q: params[:q], type: "video")
    render json: response.to_json
  end

end
