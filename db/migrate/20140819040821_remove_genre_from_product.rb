class RemoveGenreFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :genre, :string
  end
end
