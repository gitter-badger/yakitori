class AddSaleCategoryIdToSales < ActiveRecord::Migration
  def change
    add_column :sales, :sale_category_id, :integer
  end
end
