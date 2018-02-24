module Tv
  class AppsController < ApplicationController

    def index
      logger.info { "-------------" }
      logger.info { ActionController::Base.helpers.asset_path("tv.js") }
      logger.info { "-------------" }
      head :ok
    end

  end
end
