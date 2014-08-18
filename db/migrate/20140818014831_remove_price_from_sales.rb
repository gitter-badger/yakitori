class RemovePriceFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :price, :integer
  end
end
