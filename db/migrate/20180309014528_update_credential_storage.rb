class UpdateCredentialStorage < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :google_refresh_token, :string
    remove_column :accounts, :google_access_token, :string
    add_column :accounts, :google_auth_data, :string, null: false
  end
end
