class Tv::SearchesController < Tv::BaseController

  def new
    # response = client.list_searches('snippet', max_results: 25, q: params[:q], type: "video,channel,playlist")
    google = GoogleClient.new(@account.cloudkit_id)
    response = google.client.list_subscriptions("snippet,contentDetails", mine: true, max_results: 50).items.map

    render json: response.to_json
  end

end
