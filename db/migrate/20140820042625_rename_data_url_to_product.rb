class RenameDataUrlToProduct < ActiveRecord::Migration
  def up
    rename_column :products, :data_url, :exported_name
  end

  def down
    rename_column :products, :exported_name, :data_url
  end
end
