class Product < ActiveRecord::Base
  has_many :sale_products
  has_many :sales, :through => :sale_products
  belongs_to :genre

  before_save :set_property, :save_thumb, :save_exported_as_zip
  
  attr_accessor :thumbnail_file, :exported_file
  
  validates :name, :genre_id,:category, :thumbnail_file, :exported_file,  presence: {message: 'すべての項目が入力必須です。'}
  validates :name, uniqueness: {message: 'この表示名は既に使用されています。'}
  validates :genre_id, numericality: true
  validate :thumbnail_file_format_check
  validate :exported_file_format_check

  def thumbnail_file_format_check
    if (thumbnail_file && thumbnail_file.original_filename !~ %r{\.(bmp|gif|jpg|jpeg|png)\z}i)
      errors.add(:thumbnail_file, 'サムネイル画像の拡張子が不正です。')
    end
  end

  def exported_file_format_check
    if (exported_file && exported_file.original_filename !~ %r{\.(sklp|skbn)\z}i)
    errors.add(:exported_file, 'エクスポートデータの拡張子が不正です。')
    end
  end

  CATEGORIES = {
    '0' => '無料',
    '3' => '有料'
  }

  def genre_choices
    Genre.pluck(:name, :id_label)
  end

  def category_choices
    CATEGORIES.map{|k, v| [v, k]}
  end

  def category_name
    Product::CATEGORIES[category]
  end

  def next_label
    count_up current_label
  end

  private

    def current_label
      first = Product.where(genre_id: genre_id, category: category).order('label DESC').first
      if first
        first.label
      else
        free? ? Genre.where(id: genre_id).pluck(:free_label).first :
          Genre.where(id: genre_id).pluck(:pay_label).first
      end
    end

    def count_up(label)
      if free?
        counter = label[2, 4].to_i(10)
        'F' + genre_id.to_s + format('%04d', counter + 1)
      else
        counter = label[1, 3].hex
        genre_id.to_s + format('%03x', counter + 1)
      end
    end

    def free?
      category == '0'
    end

    def set_property
      self.label = self.next_label
      self.thumbnail_name = self.label + File.extname(self.thumbnail_file.original_filename)
      self.exported_name = self.label + '.zip'
      self.version ||= '1'
    end

    def save_thumb
      dest = Rails.root.join('var', 'thumb', thumbnail_name).to_s
      Utils.write_str(self.thumbnail_file.read.force_encoding('UTF-8'), dest)
    end

    def save_exported_as_zip
      tmp = Rails.root.join('var', 'tmp')
      data = Rails.root.join('var', 'data')

      tmp_zip_path = tmp.join(exported_name).to_s
      Utils.write_str(exported_file.read.force_encoding('UTF-8'), tmp_zip_path)

      unzipped_path = tmp.join(label).to_s
      Utils.unzip_with_pass(tmp_zip_path, unzipped_path, UNZIP_PASS)

      edited_path = data.join(label).to_s
      edit_exported(unzipped_path, edited_path)

      zip_path = data.join(exported_name).to_s
      Utils.zip_with_pass(edited_path, zip_path, ZIP_PASS)
    end

    def edit_exported(src, dest)
      xml = create_meta_xml(generate_hash(Product.unique_str(src)))
      Utils.write_str(xml.to_s, File.join(src, 'meta.xml'))

      genre.edit(src)

      genre.pickup(src, dest)
    end

    def create_meta_xml(hash_str)
      id = REXML::Element.new('id')
      id.add_text((free?) ? '' : label)

      genre = REXML::Element.new('genre')
      genre.add_text(genre_id.to_s)

      hash = REXML::Element.new('hash')
      hash.add_text(hash_str)

      version = REXML::Element.new('version')
      version.add_text(self.version)

      setting = REXML::Element.new('setting')
      setting.add_element(id)
      setting.add_element(genre)
      setting.add_element(hash)
      setting.add_element(version)

      doc = REXML::Document.new()
      doc.add(REXML::XMLDecl.new(version='1.0', encoding='UTF-8'))
      doc.add(setting)
    end

    def generate_hash(unique_str)
      product_id = (free?) ? '' : label
      Digest::SHA256.hexdigest(product_id + unique_str + HASH_SALT).encode('UTF-8')
    end

    def self.unique_str(dest)
      #'.'と'..'を除く先頭
      Dir.entries(File.join(dest, 'editors').to_s)[2]
    end
end
