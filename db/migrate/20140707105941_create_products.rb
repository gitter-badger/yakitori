class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :version
      t.string :genre_id
      t.string :thumbnail_url
      t.string :product_data_url
      t.string :category_id
      t.string :package_id

      t.timestamps
    end
  end
end
