Yt.configure do |config|
  config.client_id = Rails.application.secrets.google_id
  config.client_secret = Rails.application.secrets.google_secret
end