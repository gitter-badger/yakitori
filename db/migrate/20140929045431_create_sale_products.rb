class CreateSaleProducts < ActiveRecord::Migration
  def change
    create_table :sale_products do |t|

      t.timestamps
    end
  end
end
