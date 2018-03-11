class Tv::SearchesController < Tv::BaseController

  def new
    # ,channel,playlist
    google = GoogleClient.new(@account.cloudkit_id)
    items = google.client.list_searches('snippet', max_results: 25, q: params[:q], type: "video").items

    @videos = items.map do |data|
      Video.new_from_api(@account, data).tap do |video|
        video.id = (10_000..11_000).to_a.sample
      end
    end

    render template: 'tv/videos/index'
  end

end
