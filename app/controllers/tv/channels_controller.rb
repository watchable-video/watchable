class Tv::ChannelsController < Tv::BaseController

  def show
    google = GoogleClient.new(@account.cloudkit_id)
    @channel = VideoChannel.new(google.channel(params[:id]))
    @channel.id = (1000..1100).to_a.sample
  end

end
