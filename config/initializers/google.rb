require 'google/apis/youtube_v3'

Google::Apis.logger.level = Logger::ERROR

GOOGLE_CLIENT_ID = Google::Auth::ClientId.new(Rails.application.secrets.google_id, Rails.application.secrets.google_secret)
