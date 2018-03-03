class TvController < ApplicationController
  def app
    redirect_to helpers.asset_url("tv.js")
  end
end