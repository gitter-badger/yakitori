class AddColumnToSaleProduct < ActiveRecord::Migration
  def change
    add_column :sale_products, :sale_id, :integer
    add_column :sale_products, :product_id, :integer
  end
end
