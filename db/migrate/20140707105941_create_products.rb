class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :version
      t.string :genre
      t.string :thumbnail_url
      t.string :data_url
      t.string :category

      t.timestamps
    end
  end
end
