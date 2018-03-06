class Tv::SearchesController < Tv::BaseController

  def new
    collection = Yt::Collections::Videos.new(auth: client.auth)
    results = collection.where(order: 'relevance', max_results: 15, q: params[:q])

    index = 0
    @videos = []
    results.map do |result|
      index += 1
      break if index == 15
      video = Video.new_from_yt(@account, result, true)
      video.id = index
      @videos.push video
    end

    render template: 'tv/videos/index'
  end

  private

    def client
      @client ||= Yt::Account.new access_token: @account.google_access_token, refresh_token: @account.google_refresh_token
    end
end
