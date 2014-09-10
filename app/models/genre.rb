require "rexml/document"
include REXML

class Genre < ActiveRecord::Base
  has_many :products

  def pickup(src, dest)
    if id_label == 1 then #ページ
      required_files = %w(editors image lp.xml meta.xml)
    elsif id_label == 2 then #バナー
      required_files = %w(editors meta.xml)
    else
      raise 'caught unknown genre name. please branch off elsif statement.'
    end
    Genre.move_files(src, dest).call(required_files)
  end

  def edit(src)
    if id_label == 1 then #ページ
      Genre.delete_unused_tag(src)
    elsif id_label == 2 then #バナー
      #編集処理なし
    else
      raise 'caught unknown genre name. please branch off elsif statement.'
    end
  end

  private

    def self.move_files(src, dest)
      Proc.new do |files|
        files.each do |f_name|
          src_path = File.join(src, f_name).to_s
          dest_path = File.join(dest, f_name).to_s
          FileUtils.mkdir_p dest_path if File.directory? src_path
          FileUtils.cp_r(src_path, dest)
        end
      end
    end

    def self.delete_unused_tag(src)
      lp_xml = 'lp.xml'
      str = File.open(File.join(src, lp_xml)) do |f|
        f.read
      end
      File.open(File.join(src, lp_xml), 'w') do |f|
        f.write(str.gsub(/<FlgOutputCagNewPage>.*<\/OutputDir>/, ''))
      end
    end
end
