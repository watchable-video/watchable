class AddFilePathToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :file_path, :text, array: true, default: []
  end
end
