class Product < ActiveRecord::Base
  has_many :sale_products
  has_many :sales, :through => :sale_products
  belongs_to :genre

  before_save :set_property, :save_thumb, :save_exported_as_zip
  
  attr_accessor :thumbnail_file, :exported_file
  
  validates :name, :genre_id,:category, :thumbnail_file, :exported_file,  presence: true
  validates :name, allow_blank: true, uniqueness: true
  validates :genre_id, allow_blank: true, numericality: true
  validates :thumbnail_file, allow_blank: true, extension: {:white_list => %w(bmp gif jpg jpeg png)}
  validates :exported_file, allow_blank: true, extension: {:white_list => %w(sklp skbn zip)}

  CATEGORIES = {
    '0' => '無料',
    '3' => '有料'
  }

  def genre_choices
    Genre.pluck(:name, :id)
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

  def sql
    'INSERT INTO mtb_product VALUES '\
      + "('#{label}', '#{name}', '#{version}', '#{genre_id}', '#{thumbnail_name}', '#{exported_name}', '#{category}');"
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
        'F' + label[1] + format('%04d', counter + 1)
      else
        counter = label[1, 3].hex
        label[0] + format('%03x', counter + 1)
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
      dest = Rails.root.join('var', 'tmp', 'exported', label + '.zip').to_s
      Utils.file_field_save(exported_file, dest)

      src = dest
      dest = Rails.root.join('var', 'data', label + '.zip').to_s
      Utils.edit_zip_file(src, dest, UNZIP_PASS,ZIP_PASS) do |src, dest|
        xml = create_meta_xml(generate_hash(genre.unique_str(src)))
        Utils.write_str(xml.to_s, File.join(src, 'meta.xml'))

        genre.edit(src)

        genre.pickup(src, dest)
      end
    end

    def create_meta_xml(hash_str)
      id = REXML::Element.new('id')
      id.add_text((free?) ? '' : label)

      genre = REXML::Element.new('genre')
      genre.add_text(Genre.where(id: genre_id).pluck(:id_label).first.to_s)

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
      puts '*********create hash'
      puts "#{product_id} + '@' + #{unique_str} + '@' + #{HASH_SALT}"
      Digest::SHA256.hexdigest(product_id + '@' + unique_str + '@' + HASH_SALT).encode('UTF-8')
    end
end
