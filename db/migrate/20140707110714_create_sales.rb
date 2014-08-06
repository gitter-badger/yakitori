class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :sale_name
      t.text :description
      t.integer :price
      t.string :genre_id
      t.integer :display_order
      t.string :thumbnail_url
      t.string :preview1_url
      t.string :preview2_url
      t.string :preview3_url
      t.string :preview4_url
      t.string :preview5_url
      t.boolean :show_flg
      t.boolean :approval_flg
      t.boolean :new_flg
      t.integer :sale_area
      t.string :optimum_plan

      t.timestamps
    end
  end
end
