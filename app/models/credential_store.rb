require 'googleauth'
require 'googleauth/token_store'

class CredentialStore < Google::Auth::TokenStore

  def load(id)
    Account.where(cloudkit_id: id).take&.google_auth_data
  end

  def store(id, token)
    Account.where(cloudkit_id: id).first_or_create do |account|
      account.google_auth_data = token
    end
  end

  def delete(id)
    Account.where(cloudkit_id: id).take&.destroy
  end

end
