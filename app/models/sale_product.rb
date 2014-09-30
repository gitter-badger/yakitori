class SaleProduct < ActiveRecord::Base
  belongs_to :sale
  belongs_to :product

  def release
    "INSERT INTO dtb_package VALUES ('#{}', '#{Product.find(product_id).label}');"
  end
end
