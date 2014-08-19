class AddGenreToProduct < ActiveRecord::Migration
  def change
    add_column :products, :genre_id, :integer
  end
end
