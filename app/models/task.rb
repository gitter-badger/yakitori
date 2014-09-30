class Task < ActiveRecord::Base
  belongs_to :user
  has_many :sales

  attr_accessor :sale_id

  def release
    product_sql = '<<<product>>>\n'
    package_sql = '<<<package>>>\n'
    sale_sql = '<<<sale>>>\n'
    Sale.where(:task_id => id).each do |sale|
      sale_sql += sale.release
      SaleProduct.where(:sale_id => sale.id).each do |sale_product|
        package_sql += sale_product.release
        product_sql += Product.where(:id => sale_product.product_id)[0].release
      end
    end
    product_sql += '<<<product>>>\n'
    package_sql += '<<<package>>>\n'
    sale_sql += '<<<sale>>>\n'
    product_sql + package_sql + sale_sql
  end
end
