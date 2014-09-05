class Genre < ActiveRecord::Base
  belongs_to :product

  def filter(src, dist)
    REQUIRED_FILES[id].each do |f_name|
      src_path = File.join(src, f_name).to_s
      dist_path = File.join(dist, f_name).to_s
      FileUtils.mkdir_p dist_path if File.directory? src_path
      FileUtils.cp_r(src_path, dist)
    end
  end

  private

    REQUIRED_FILES = {
        1 => %w(editors image lp.xml),
        2 => %w(editors)
    }
end
