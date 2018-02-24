class OauthTwoAuthorizationsController < ApplicationController
  def new
    redirect_uri = Rails.application.routes.url_helpers.save_oauth_two_authorizations_url
    redirect_to Yt::Account.new(scopes: %w[youtube.readonly], redirect_uri: redirect_uri).authentication_url
  end

  def save
    puts session.inspect
    head :ok
  end

end
