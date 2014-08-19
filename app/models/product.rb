class Product < ActiveRecord::Base
  has_many :sale_products
  has_many :sales, :through => :sale_products
  has_one :genre

  before_create :default_value

  def default_value
    self.version ||= "1"
  end

  CATEGORYS = {
    "0" => "無料",
    "3" => "有料"
  }

  def get_genre_display_obj
    return Genre.all.pluck(:name, :id)
  end

  def get_category_display_obj
    return CATEGORYS.map{|k, v| [v, k]}
  end
end
