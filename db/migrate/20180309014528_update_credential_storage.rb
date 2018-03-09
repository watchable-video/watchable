class UpdateCredentialStorage < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :google_refresh_token
    remove_column :accounts, :google_access_token
  end
end
