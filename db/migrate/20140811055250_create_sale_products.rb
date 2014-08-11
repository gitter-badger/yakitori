class CreateSaleProducts < ActiveRecord::Migration
  def change
    create_table :sale_products do |t|
      t.integer :sale_id
      t.integer :product_id

      t.timestamps
    end
  end
end
