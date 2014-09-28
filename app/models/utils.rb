class Utils

  def self.write_str(src_str, dest_path)
    self.clean_up(dest_path)
    File.open(dest_path, 'w') do |f|
      f.write(src_str)
    end
  end

  def self.read_str(src_path)
    File.open(src_path) do |f|
      f.read
    end
  end

  def self.zip(src_path, dest_path, pass = nil)
    self.clean_up(dest_path)
    Zip::Archive.open(dest_path, Zip::CREATE) do |ar|
      Dir.glob(src_path + '/**/*').each do |path|
        unless File.directory?(path) then
          entry = path.gsub(/#{src_path}/, File.basename(dest_path, '.*'))
          # entry = path.gsub(/#{src_path}\//, '')
          ar.add_file(entry, path)
        end
      end
    end
    Zip::Archive.encrypt(dest_path, pass) unless pass == nil || pass == ''
  end

  def self.unzip(src_path, dest_path, pass = nil)
    self.clean_up(dest_path)
    Zip::Archive.open(src_path) do |arc|
      arc.decrypt(pass) unless pass == nil || pass == ''
      arc.num_files.times do |i|
        arc.fopen(arc.get_name(i)) do |file|
          if file.directory? then
            FileUtils.mkdir_p(File.join(dest_path, file.name).to_s)
          else
            FileUtils.mkdir_p(File.join(dest_path, File.dirname(file.name)).to_s)
            File.open(File.join(dest_path, file.name).to_s, 'w') do |f|
              f.write file.read.force_encoding('UTF-8')
            end
          end
        end
      end
    end
  end

  def self.zip_to_zip(edit_func)
    Proc.new do |src, dest, unzip_pass = nil, zip_pass = nil|
      unzipped_path = Rails.root.join('var', 'tmp', 'unzip').to_s
      Utils.unzip(src, unzipped_path, unzip_pass)


      unless File.exist?(File.join(unzipped_path, 'editors'))
        puts '%%%%%%%%%%%%%%%'
        puts "cd #{dest}"
        puts "cd Dir.entries(dest)[2]"
        puts "mv * ../"
      end


      if edit_func
        edited_path = Rails.root.join('var', 'tmp', 'edited').to_s
        edit_func.call(unzipped_path, edited_path)
        unzipped_path = edited_path
      end

      Utils.zip(unzipped_path, dest, zip_pass)

    end
  end

  def self.file_field_save(file_field, dest)
    Utils.write_str(file_field.read.force_encoding('UTF-8'), dest)
  end

  def self.clean_up(path)
    path = path.force_encoding('UTF-8') unless path == nil || path == ''
    if File.exist?(path) ? File.directory?(path) : File.extname(path) == ''
      FileUtils.remove_dir(path, {:force => true})
      FileUtils.mkdir_p(path)
    else
      FileUtils.remove(path, {:force => true})
      FileUtils.mkdir_p(File.dirname(path))
    end
  end

  def self.copy(src, dest)
    if File.exist?(src)
      if File.directory?(src)
        FileUtils.mkdir_p(dest)
      else
        FileUtils.mkdir_p(File.dirname(dest))
        FileUtils.cp_r(src, dest)
      end
    end
  end

  def self.move_files(src, dest, files)
    FileUtils.remove(dest, {:force => true})
    files.each do |f_name|
      src_path = File.join(src, f_name).to_s
      dest_path = File.join(dest, f_name).to_s
      FileUtils.mkdir_p dest_path if File.directory? src_path
      FileUtils.cp(src_path, dest)
    end
  end
end
