require "rexml/document"
include REXML

class Genre < ActiveRecord::Base
  has_many :products

  LP_ID_LABEL = 1
  BANNER_ID_LABEL = 2
  KANBAN_ID_LABEL = 3
  SHOP_ID_LABEL = 4
  SMPTOP_ID_LABEL = 5

  def pickup(src, dest)
    case id_label
      when LP_ID_LABEL then
        required_files = %w(editors image lp.xml meta.xml)
      when BANNER_ID_LABEL then
        required_files = %w(editors meta.xml)
      when KANBAN_ID_LABEL then
        required_files = %w(editors image setting.xml meta.xml)
      when SHOP_ID_LABEL then
        required_files = %w(calendar_title.gif category_title.gif parent_category.gif child_category.gif ranking_title.gif rank1.gif
                          rank2.gif rank3.gif rank4.gif rank5.gif rank_up.gif rank_down.gif rank_stay.gif footer_title840.gif
                          footer_point.gif template.xml preview.png meta.xml)

      when SMPTOP_ID_LABEL then
        required_files = %w(kanban/editors kanban/image/output.jpg kanban/image/thumb.jpg title_image/ranking/image/output.jpg
                          title_image/ranking/editors title_image/ranking/image/thumb.jpg title_image/newarrival/editors
                          title_image/newarrival/image/output.jpg title_image/newarrival/image/thumb.jpg template.xml meta.xml)
      else
        raise 'caught unknown genre name. please branch off elsif statement.'
    end
    Genre.move_files(src, dest, required_files)
  end

  def edit(src)
    case id_label
      when LP_ID_LABEL
        Genre.edit_lp_xml(src)
      when BANNER_ID_LABEL, KANBAN_ID_LABEL, SHOP_ID_LABEL, SMPTOP_ID_LABEL
        #編集処理なし
      else
      raise 'caught unknown genre name. please branch off elsif statement.'
    end
  end


  def unique_str(dest)
    case id_label
      when LP_ID_LABEL, BANNER_ID_LABEL
        Genre.fist_filename(File.join(dest, 'editors').to_s)
      when KANBAN_ID_LABEL
        Genre.two_or_more_filename(File.join(dest, 'editors').to_s)
      when SHOP_ID_LABEL
        Genre.join_tag_contents(File.join(dest, 'template.xml').to_s)
      when SMPTOP_ID_LABEL
        Genre.fist_filename(File.join(dest, 'kanban/editors').to_s)
      else
        raise 'caught unknown genre name. please branch off elsif statement.'
    end
  end

  private

    def self.move_files(src, dest, files)
      `rm -rf #{File.join(dest, '*').to_s}`
      files.each do |f_name|
        src_path = File.join(src, f_name).to_s
        `cp -r #{src_path} #{File.join(dest, f_name).to_s}` if File.directory?(src_path)

        if File.file?(src_path)
          `mkdir -p #{File.join(dest, File.dirname(f_name))}`
          puts "mkdir -p #{File.join(dest, File.dirname(f_name))}"
          `cp #{src_path} #{File.join(dest, f_name).to_s}`
        end
      end
    end

    def self.edit_lp_xml(src)
      src_path = File.join(src, 'lp.xml').to_s
      str = Utils.read_str(src_path)
        .gsub(/<page_title>.*?<\/page_title>/, '<page_title>新規ページ</page_title>')
        .gsub(/<FlgOutputCagNewPage>.*?<\/OutputDir>/, '')
      Utils.write_str(str, src_path)
    end

    def self.join_tag_contents(src)
      doc = REXML::Document.new(open(src))
      doc.elements['style/product_detail/title_background_color'].text +
        doc.elements['style/product_detail/title_font_color'].text +
        doc.elements['style/product_detail/statement_background_color'].text +
        doc.elements['style/product_detail/statement_font_color'].text
    end

    def self.fist_filename(path)
      #'.'と'..'を除く先頭
      Dir.entries(path)[2]
    end

    def self.two_or_more_filename(path)
      #'.'と'..'を除く先頭
      Dir.entries(path).each_with_index do |name, i|
        return name if i > 1 && name.to_s.length > 1
      end
    end
end
