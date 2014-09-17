class Utils

  def self.write_file(src_path, dest_path)
    File.open(dest, 'w'){|f|
      f.write()
    }
  end

  def self.write_str(src_str, dest_path)
    File.open(dest_path, 'w') do |f|
      f.write(src_str)
    end
  end

  def self.read_str(src_path)
    File.open(src_path) do |f|
      f.read
    end
  end

  def self.zip(src_path, dest_path)
    FileUtils.remove([dest_path], {:force => true})
    Zip::Archive.open(dest_path, Zip::CREATE) do |ar|
      Dir.glob(src_path + '/**/*').each do |path|
        unless File.directory?(path)
          #add_file(<entry name>, <source path>)
          ar.add_file(path.gsub(/#{src_path}\//, ''), path)
        end
      end
    end
  end

  def self.zip_with_pass(src_path, dest_path, pass)
    self.zip(src_path, dest_path)
    Zip::Archive.encrypt(dest_path, pass)
  end

  def self.unzip_with_pass(src_path, dest_path, pass)
    FileUtils.remove([dest_path], {:force => true})
    Zip::Archive.open(src_path) do |arc|
      arc.decrypt(pass)
      arc.num_files.times do |i|
        arc.fopen(arc.get_name(i)) do |file|
          if file.directory? then
            FileUtils.mkdir_p(File.join(dest_path, file.name).to_s)
          else
            File.open(File.join(dest_path, file.name).to_s, 'w') do |f|
              f.write file.read.force_encoding('UTF-8')
            end
          end
        end
      end
    end
  end

end
