class AddPriceToSales < ActiveRecord::Migration
  def change
    add_column :sales, :price_id, :integer
  end
end
