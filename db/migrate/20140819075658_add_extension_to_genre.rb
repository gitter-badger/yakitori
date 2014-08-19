class AddExtensionToGenre < ActiveRecord::Migration
  def change
    add_column :genres, :extension, :string
  end
end
