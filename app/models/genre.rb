require "rexml/document"
include REXML

class Genre < ActiveRecord::Base
  has_many :products

  def filter(src, dest)
    REQUIRED_FILES[self.id].each do |f_name|
      src_path = File.join(src, f_name).to_s
      dest_path = File.join(dest, f_name).to_s
      FileUtils.mkdir_p dest_path if File.directory? src_path
      FileUtils.cp_r(src_path, dest)
    end
  end

  def trimming(src)
    TRIMMERS[self.id].call(src)
  end

  def create_meta_xml(dest, label)
    id = REXML::Element.new('id')
    id.add_text(label)

    genre = REXML::Element.new('genre')
    genre.add_text(self.id.to_s)

    hash = REXML::Element.new('hash')
    hash.add_text(Genre.generate_hash(dest, label))

    version = REXML::Element.new('version')
    version.add_text('1')

    setting = REXML::Element.new('setting')
    setting.add_element(id)
    setting.add_element(genre)
    setting.add_element(hash)
    setting.add_element(version)

    doc = REXML::Document.new()
    doc.add(REXML::XMLDecl.new(version='1.0', encoding='UTF-8'))
    doc.add(setting)

    File.open(File.join(dest, 'meta.xml'), 'w') do |f|
      f.write(doc)
    end
  end

  private

    REQUIRED_FILES = {
      1 => %w(editors image lp.xml),
      2 => %w(editors)
    }

    TRIMMERS = {
      1 => ->(src){ lp_trimming(src)},
      2 => ->(src){banner_trimming(src)}
    }


    def self.lp_trimming(src)
      lp_xml = 'lp.xml'
      str = File.open(File.join(src, lp_xml)) do |f|
        f.read
      end
      File.open(File.join(src, lp_xml), 'w') do |f|
        f.write(str.gsub(/<FlgOutputCagNewPage>.*<\/OutputDir>/, ''))
      end
    end

    def self.banner_trimming(src)
      #処理なし
    end

    def self.generate_hash(dest, label)
      Digest::SHA256.hexdigest(label + Genre.unique_str(dest) + Genre.salt).encode('UTF-8')
    end

    def self.unique_str(dest)
      #'.'と'..'を除く先頭
      Dir.entries(File.join(dest, 'editors').to_s)[2]
    end

    def self.salt
    end
end
