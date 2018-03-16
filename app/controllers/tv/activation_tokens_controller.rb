class Tv::ActivationTokensController < Tv::BaseController

  skip_before_action :authorize, only: [:create]

  def create
    @activation_token = ActivationToken.create!(cloudkit_id: params[:cloudkit_id])
  end

end

