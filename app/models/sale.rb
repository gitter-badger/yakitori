class Sale < ActiveRecord::Base
  belongs_to :task
  has_many :sale_products
  has_many :products, :through => :sale_products  
  belongs_to :price
  belongs_to :sale_category
end
