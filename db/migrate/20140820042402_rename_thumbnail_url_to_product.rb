class RenameThumbnailUrlToProduct < ActiveRecord::Migration
  def up
    rename_column :products, :thumbnail_url, :thumbnail_name
  end

  def down
    rename_column :products, :thumbnail_name, :thumbnail_url
  end
end
