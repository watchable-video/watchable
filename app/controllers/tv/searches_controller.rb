require 'google/apis'
require 'google/apis/youtube_v3'
require 'googleauth'
require 'googleauth/stores/redis_token_store'

class Tv::SearchesController < Tv::BaseController

  def new
    response = client.list_searches('snippet', max_results: 25, q: params[:q], type: "video,channel,playlist")
    render json: response.to_json
  end

  private

    def client
      @client ||= begin
        scopes = ["https://www.googleapis.com/auth/youtube.readonly"]
        token_store = Google::Auth::Stores::RedisTokenStore.new()
        authorizer = Google::Auth::UserAuthorizer.new(GOOGLE_CLIENT_ID, scopes, token_store)
        authorize = authorizer.get_credentials(@account.cloudkit_id)
        service = Google::Apis::YoutubeV3::YouTubeService.new
        service.authorization = authorize
        service
      end

    end
end
