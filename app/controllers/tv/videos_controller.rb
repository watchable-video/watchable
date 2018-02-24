class Tv::VideosController < Tv::BaseController

  def index

  end

  private

  def account
    Account.last
  end
end
