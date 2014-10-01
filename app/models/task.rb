class Task < ActiveRecord::Base
  belongs_to :user
  has_many :sales

  attr_accessor :sale_id

  def app_type_choices
    [
      ['赤', 0],
      ['青', 1]
    ]
  end

  def paid_choices
    [
      ['無料', 0],
      ['有料', 1]
    ]
  end

  def release
    #MEMO nakao rubyで'\n'は改行でない
    product_sql = "-- ↓↓↓↓↓for mtb_product↓↓↓↓↓\n"
    package_sql = "-- ↓↓↓↓↓for dtb_package↓↓↓↓↓\n"
    sale_sql = "-- ↓↓↓↓↓for mtb_sale↓↓↓↓↓\n"
    Sale.where(:task_id => id).each do |sale|
      sale_sql += sale.release
      SaleProduct.where(:sale_id => sale.id).each do |sale_product|
        package_sql += sale_product.release
        product_sql += Product.where(:id => sale_product.product_id)[0].release
      end
    end
    product_sql += "\n-- ↑↑↑↑↑for mtb_product↑↑↑↑↑\n\n"
    package_sql += "\n-- ↑↑↑↑↑for dtb_package↑↑↑↑↑\n\n"
    sale_sql += "\n-- ↑↑↑↑↑for mtb_sale↑↑↑↑↑\n\n"
    product_sql + package_sql + sale_sql
  end
end
