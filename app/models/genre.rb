class Genre < ActiveRecord::Base
  has_many :product
end
