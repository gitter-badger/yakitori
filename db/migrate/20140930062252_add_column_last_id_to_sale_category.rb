class AddColumnLastIdToSaleCategory < ActiveRecord::Migration
  def change
    add_column :sale_categories, :last_id, :string
  end
end
