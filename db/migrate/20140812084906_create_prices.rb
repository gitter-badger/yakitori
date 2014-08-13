class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :value

      t.timestamps
    end
  end
end
