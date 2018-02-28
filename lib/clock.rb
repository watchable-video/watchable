require 'clockwork'
require_relative '../config/boot'
require_relative '../config/environment'

include Clockwork

every(10.seconds, 'clockwork.very_frequent') do
end
