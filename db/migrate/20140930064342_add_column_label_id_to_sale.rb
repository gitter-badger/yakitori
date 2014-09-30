class AddColumnLabelIdToSale < ActiveRecord::Migration
  def change
    add_column :sales, :label_id, :string
  end
end
