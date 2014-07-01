class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :app_type
      t.integer :paid
      t.datetime :release_at

      t.timestamps
    end
  end
end
