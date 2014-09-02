class Product < ActiveRecord::Base
  has_many :sale_products
  has_many :sales, :through => :sale_products
  belongs_to :genre

  before_create :default_value
  before_save :save_files
  
  attr_accessor :thumbnail_file, :exported_file
  
  validates :name, :genre_id,:category, :thumbnail_file, :exported_file,  presence: {message: "すべての項目が入力必須です。"}
  validates :name, uniqueness: {message: "この表示名は既に使用されています。"}
  validates :genre_id, numericality: true
  validate :thumbnail_file_format_check
  validate :exported_file_format_check

  def thumbnail_file_format_check
    if (thumbnail_file && thumbnail_file.original_filename !~ %r{\.(bmp|gif|jpg|jpeg|png)\z}i)
      errors.add(:thumbnail_file, "サムネイル画像の拡張子が不正です。")
    end
  end

  def exported_file_format_check
    if (exported_file && exported_file.original_filename !~ %r{\.(sklp|skbn)\z}i)
    errors.add(:exported_file, "エクスポートデータの拡張子が不正です。") 
    end
  end
  
  def default_value
    self.version ||= "1"
  end
  
  CATEGORYS = {
    "0" => "無料",
    "3" => "有料"
  }

  def genre_choices
    return Genre.pluck(:name, :id)
  end

  def category_choices
    return CATEGORYS.map{|k, v| [v, k]}
  end

  def category_name
    Product::CATEGORYS[self.category]
  end

  def next_label
    return count_up current_label
  end

  private
    def current_label
      first = Product.where(genre_id: self.genre_id).where(category: self.category).order("label DESC").first
      if first
        return first.label
      else
       return free? ? Genre.where(id: self.genre_id).pluck(:free_label).first : 
          Genre.where(id: self.genre_id).pluck(:pay_label).first
      end
    end

    def count_up(label)
      if free?
        counter = label[2, 4].to_i(10)
        return "F" +  self.genre_id.to_s + format("%04d", counter + 1)
      else
        counter = label[1, 3].hex
        return self.genre_id.to_s + format("%03x", counter + 1)
      end
    end

    def free?
      return self.category == "0"
    end

    def save_files
      self.label = self.next_label
      self.thumbnail_name = self.label + File.extname(self.thumbnail_file.original_filename)
      self.exported_name = self.label + File.extname(self.exported_file.original_filename)

      base = Rails.root.join("var")
      save_file(base.join("thumb").join(self.thumbnail_name).to_s, self.thumbnail_file)
      save_file(base.join("data").join(self.exported_name).to_s, self.exported_file)
    end

    def save_file(path, file)
      File.open(path, 'w'){|f| 
        f.write(file.read.force_encoding("UTF-8"))
      }
    end

end
