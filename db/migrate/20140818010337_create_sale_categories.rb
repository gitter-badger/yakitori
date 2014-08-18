class CreateSaleCategories < ActiveRecord::Migration
  def change
    create_table :sale_categories do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
  end
end
