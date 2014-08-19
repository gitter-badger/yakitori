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
    return Genre.pluck(:name, :id)
  end

  def get_category_display_obj
    return CATEGORYS.map{|k, v| [v, k]}
  end

  def get_next_label
    return count_up get_current_label
  end

  def get_current_label
    first = Product.where(genre_id: self.genre_id).where(category: self.category).order("label DESC").first
    if first
      return first.label
    else
     return is_free ? Genre.where(id: self.genre_id).pluck(:free_label).first : 
        Genre.where(id: self.genre_id).pluck(:pay_label).first
    end
  end
  private :get_current_label

  def count_up(label)
    if is_free
      counter = label[2, 4].to_i(10)
      return "F" +  self.genre_id.to_s + format("%04d", counter + 1)
    else
      counter = label[1, 3].hex
      return self.genre_id.to_s + format("%03x", counter + 1)
    end
  end
  private :count_up

  def is_free
    return self.category == "0"
  end
  private :is_free
end
