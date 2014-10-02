class SaleProduct < ActiveRecord::Base
  belongs_to :sale
  belongs_to :product

  def sql
    "INSERT INTO dtb_package VALUES ('#{Sale.find(sale_id).label_id}', '#{Product.find(product_id).label}');"
  end
end
