class AddColumnToGenre < ActiveRecord::Migration
  def change
    add_column :genres, :id_label, :integer
  end
end
