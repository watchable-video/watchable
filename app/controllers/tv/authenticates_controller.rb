class Tv::AuthenticatesController < Tv::BaseController

  def new
    head :ok
  end

  def sync_status
    status = @account.initial_sync_complete ? :ok : :unauthorized
    render json: {status: status}, status: status
  end

end
