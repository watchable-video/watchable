require 'clockwork'
require_relative '../config/boot'
require_relative '../config/environment'

include Clockwork

every(1.hour, 'clockwork.hourly') do
  Account.find_each do |account|
    RefreshJob.perform_later account
  end
end
