class CreateActivationTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :activation_tokens do |t|
      t.string :cloudkit_id, null: false
      t.string :token, null: false

      t.timestamps
    end
    add_index :activation_tokens, [:cloudkit_id, :token], unique: true
  end
end
