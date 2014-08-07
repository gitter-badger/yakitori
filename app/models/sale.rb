class Sale < ActiveRecord::Base
  belongs_to :task
  has_many :sale_product
  has_many :product, :through => :sale_product  
end
