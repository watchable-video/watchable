require 'googleauth'
require 'googleauth/web_user_authorizer'

class AccountsController < ApplicationController

  def create
    if token = ActivationToken.where(token: params[:token]).where("created_at > ?", 15.minutes.ago).take
      if authorizer.get_credentials(token.cloudkit_id, request).blank?
        session[:cloudkit_id] = token.cloudkit_id
        redirect_to authorizer.get_authorization_url(login_hint: token.cloudkit_id, request: request)
      else
        render "save"
      end
    else
      render "create_error"
    end
  end

  def save
    authorizer.handle_auth_callback(session[:cloudkit_id], request)
  end

  private

    def authorizer
      @authorizer ||= begin
        redirect_uri = Rails.application.routes.url_helpers.save_accounts_url
        scopes = ["https://www.googleapis.com/auth/youtube.readonly"]
        token_store = CredentialStore.new()
        Google::Auth::WebUserAuthorizer.new(GOOGLE_CLIENT_ID, scopes, token_store, redirect_uri)
      end
    end
end
