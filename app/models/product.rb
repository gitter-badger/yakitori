class Product < ActiveRecord::Base
  has_many :sale_products
  has_many :sales, :through => :sale_products

  before_create :default_value

  def default_value
    self.version ||= "1"
  end

  
  GENRES = {
    "1" => "ページ",
    "2" => "バナー",
    "3" => "看板",
    "4" => "お店",
    "5" => "スマホトップ",
    "6" => "スマホ大バナー",
    "7" => "スマホ小バナー",
    "8" => "スマホLP"
  }

  CATEGORYS = {
    "0" => "無料",
    "3" => "有料"
  }

  def get_genre_display_obj
    obj = []
    for num in 1..GENRES.length do
      obj << [GENRES[num.to_s], num.to_s]
    end
    return obj
  end

  def get_category_display_obj
    obj = []
    for num in 0..3 do
      if (CATEGORYS.has_key?(num.to_s))
        obj << [CATEGORYS[num.to_s], num.to_s]
      end
    end
    return obj
  end
end
