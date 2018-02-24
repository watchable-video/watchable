class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :cloudkit_id, null: false
      t.string :google_code, null: false

      t.timestamps
    end

    add_index :accounts, :cloudkit_id, unique: true

  end
end
