require 'googleauth'
require 'googleauth/web_user_authorizer'

class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    session[:cloudkit_id] = params[:account][:cloudkit_id]
    credentials = authorizer.get_credentials(session[:cloudkit_id], request)
    if !credentials
      redirect_to authorizer.get_authorization_url(login_hint: session[:cloudkit_id], request: request)
    end
  end

  def save
    authorizer.handle_auth_callback(session[:cloudkit_id], request)
    head :ok
  end

  private

    def authorizer
      redirect_uri = Rails.application.routes.url_helpers.save_accounts_url
      scopes = ["https://www.googleapis.com/auth/youtube.readonly"]
      token_store = CredentialStore.new()
      Google::Auth::WebUserAuthorizer.new(GOOGLE_CLIENT_ID, scopes, token_store, redirect_uri)
    end
end
