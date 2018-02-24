class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    session[:cloudkit_id] = params[:account][:cloudkit_id]
    redirect_uri = Rails.application.routes.url_helpers.save_accounts_url
    redirect_to Yt::Account.new(scopes: %w[youtube.readonly], redirect_uri: redirect_uri).authentication_url
  end

  def save
    Account.create!(cloudkit_id: session[:cloudkit_id], google_code: params[:code])
    head :ok
  end

end
