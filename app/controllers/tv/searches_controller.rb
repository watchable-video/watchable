class Tv::SearchesController < Tv::BaseController

  def new
    # ,channel,playlist
    google = GoogleClient.new(@account.cloudkit_id)
    items = google.client.list_searches('snippet', max_results: 25, q: params[:q], type: "video,channel").items

    @results = items.map do |data|
      if data.id.kind == "youtube#channel"
        result = VideoChannel.new(data)
      else
        result = Video.new_from_api(@account, data)
      end

      result.tap do |r|
        r.id = (100_000_000_000..100_000_001_000).to_a.sample
      end
    end
  end

end

