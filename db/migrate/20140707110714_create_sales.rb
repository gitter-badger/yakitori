class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :genre_id
      t.integer :display_order
      t.string :thumbnail_url
      t.string :preview1_url
      t.string :preview2_url
      t.string :preview3_url
      t.string :preview4_url
      t.string :preview5_url
      t.boolean :visible
      t.datetime :approval_at
      t.boolean :is_new
      t.integer :area
      t.string :optimum_plan
      t.integer :task_id

      t.timestamps
    end
  end
end
