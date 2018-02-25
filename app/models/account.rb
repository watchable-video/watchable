class Account < ApplicationRecord

  def self.create_from_yt!(cloudkit_id, account)
    params = {
      cloudkit_id: cloudkit_id,
      google_access_token: account.authentication.access_token,
      google_refresh_token: account.authentication.refresh_token
    }
    create!(params)
  end
end
