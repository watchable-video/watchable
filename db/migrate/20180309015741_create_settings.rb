class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.belongs_to :account, foreign_key: true
      t.integer :name, null: false
      t.jsonb :data, null: false
      t.timestamps
    end
  end
end
