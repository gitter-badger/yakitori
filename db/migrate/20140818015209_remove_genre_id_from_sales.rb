class RemoveGenreIdFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :genre_id, :integer
  end
end
