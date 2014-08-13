class Product < ActiveRecord::Base
  has_many :sale_products
  has_many :sales, :through => :sale_products

  before_create :default_value

  def default_value
    self.version ||= "1"
    #thumbnail_urlとdata_urlは本番DBから引き継ぐ連続するIDによって決定される。
    #その処理は後でかく。
    self.thumbnail_url ||= "tmp.png"
    self.data_url ||= "tmp.zip"
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
    return GENRES.map{|k, v| [v, k]}
  end

  def get_category_display_obj
    return CATEGORYS.map{|k, v| [v, k]}
  end
end
