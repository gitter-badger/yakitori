require "rexml/document"
include REXML

class Genre < ActiveRecord::Base
  has_many :products

  LP_ID_LABEL = 1
  BANNER_ID_LABEL = 2

  def pickup(src, dest)
    if id_label == LP_ID_LABEL then
      required_files = %w(editors image lp.xml meta.xml)
    elsif id_label == BANNER_ID_LABEL then
      required_files = %w(editors meta.xml)
    else
      raise 'caught unknown genre name. please branch off elsif statement.'
    end
    Genre.move_files(src, dest, required_files)
  end

  def edit(src)
    if id_label == LP_ID_LABEL then
      Genre.edit_tag(src)
    elsif id_label == BANNER_ID_LABEL then
      #編集処理なし
    else
      raise 'caught unknown genre name. please branch off elsif statement.'
    end
  end

  private

    def self.move_files(src, dest, files)
      FileUtils.remove(dest, {:force => true})
      files.each do |f_name|
        src_path = File.join(src, f_name).to_s
        dest_path = File.join(dest, f_name).to_s
        FileUtils.mkdir_p dest_path if File.directory? src_path
        FileUtils.cp_r(src_path, dest)
      end
    end

    def self.edit_tag(src)
      src_path = File.join(src, 'lp.xml').to_s
      str = Utils.read_str(src_path)
        .gsub(/<page_title>.*?<\/page_title>/, '<page_title>新規ページ</page_title>')
        .gsub(/<FlgOutputCagNewPage>.*?<\/OutputDir>/, '')
      Utils.write_str(str, src_path)
    end
end
