class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :youtube_id, null: false
      t.string :cloudkit_id, null: false
      t.datetime :video_published_at, null: false
      t.jsonb :data

      t.timestamps
    end

    add_index :videos, [:cloudkit_id, :youtube_id], unique: true

  end
end
