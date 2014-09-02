class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name
      t.string :pay_label
      t.string :free_label

      t.timestamps
    end
  end
end
