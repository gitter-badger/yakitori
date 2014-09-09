class Product < ActiveRecord::Base
  has_many :sale_products
  has_many :sales, :through => :sale_products
  belongs_to :genre

  before_create :default_value
  before_save :before_save
  
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
  
  def default_value
    self.version ||= '1'
  end
  
  CATEGORYS = {
    '0' => '無料',
    '3' => '有料'
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
      first = Product.where(genre_id: self.genre_id).where(category: self.category).order('label DESC').first
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
        return 'F' +  self.genre_id.to_s + format('%04d', counter + 1)
      else
        counter = label[1, 3].hex
        return self.genre_id.to_s + format('%03x', counter + 1)
      end
    end

    def free?
      return self.category == '0'
    end

    def before_save
      set_property()

      var = Rails.root.join('var')
      save_thumb(var.join('thumb', self.thumbnail_name).to_s)

      zip_path = var.join('tmp', self.exported_name).to_s
      unzip_path = var.join('tmp', self.label).to_s
      save_exported(zip_path)
      unzip_exported(zip_path, unzip_path)

      retouched_path = var.join('data', self.label).to_s
      created_zip_path = var.join('data', self.exported_name).to_s
      retouch_exported(unzip_path, retouched_path)
      zip_exported(retouched_path, created_zip_path)

      Zip::Archive.encrypt(created_zip_path, zip_pass)
    end

    def set_property
      self.label = self.next_label
      self.thumbnail_name = self.label + File.extname(self.thumbnail_file.original_filename)
      self.exported_name = self.label + '.zip'
    end

    def save_thumb(dest)
      save_file(self.thumbnail_file, dest)
    end

    def save_exported(dest)
      save_file(self.exported_file, dest)
    end

    def retouch_exported(src, dest)
      self.genre.filter(src, dest)
      self.genre.trimming(dest)
      self.genre.create_meta_xml(dest, (free?) ? '' : self.label)
    end

    def save_file(src_file, dest)
      File.open(dest, 'w'){|f|
        f.write(src_file.read.force_encoding('UTF-8'))
      }
    end

    def unzip_exported(src, dest)
      Zip::Archive.open(src) do |arc|
        arc.decrypt(unzip_pass)
        arc.num_files.times do |i|
          arc.fopen(arc.get_name(i)) do |file|
            if file.directory? then
              puts FileUtils.mkdir_p(File.join(dest, file.name).to_s)
            else
              File.open(File.join(dest, file.name).to_s, 'w') do |f|
                f.write file.read.force_encoding('UTF-8')
              end
            end
          end
        end
      end
    end

    def zip_exported(src, dest)
      Zip::Archive.open(dest, Zip::CREATE) do |ar|
        Dir.glob(src + '/**/*').each do |path|
          unless File.directory?(path)
            # add_file(<entry name>, <source path>)
            ar.add_file(path.gsub(/#{src}\//, ''), path)
          end
        end
      end
    end

    def unzip_pass
    end

    def zip_pass
    end
end
