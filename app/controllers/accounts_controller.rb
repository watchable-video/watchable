require 'googleauth'
require 'googleauth/web_user_authorizer'
require 'googleauth/stores/redis_token_store'

class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    session[:cloudkit_id] = params[:account][:cloudkit_id]

    scope = ["https://www.googleapis.com/auth/youtube.readonly"]
    token_store = Google::Auth::Stores::RedisTokenStore.new()
    authorizer = Google::Auth::WebUserAuthorizer.new(GOOGLE_CLIENT_ID, scope, token_store, redirect_uri)

    user_id = params[:account][:cloudkit_id]
    credentials = authorizer.get_credentials(session[:cloudkit_id], request)
    if credentials
      logger.info { "has credentials" }
    else
      redirect_to authorizer.get_authorization_url(login_hint: session[:cloudkit_id], request: request)
    end
  end

  def save
    Google::Auth::WebUserAuthorizer.handle_auth_callback_deferred(request)
    head :ok
  end

  private

    def redirect_uri
      Rails.application.routes.url_helpers.save_accounts_url
    end

end

