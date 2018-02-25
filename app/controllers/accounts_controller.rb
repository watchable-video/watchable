class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    session[:cloudkit_id] = params[:account][:cloudkit_id]
    redirect_to Yt::Account.new(scopes: %w[youtube.readonly], redirect_uri: redirect_uri).authentication_url
  end

  def save
    account = Yt::Account.new authorization_code: params[:code], redirect_uri: redirect_uri
    Account.create_from_yt!(session[:cloudkit_id], account)
    head :ok
  end

  private

    def redirect_uri
      Rails.application.routes.url_helpers.save_accounts_url
    end

end
