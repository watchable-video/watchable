class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :cloudkit_id, null: false
      t.string :google_access_token, null: false
      t.string :google_refresh_token, null: false

      t.timestamps
    end

    add_index :accounts, :cloudkit_id, unique: true

  end
end
