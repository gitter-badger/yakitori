class Product < ActiveRecord::Base
  has_many :sale_product
  has_many :sale, :through => :sale_product
end
