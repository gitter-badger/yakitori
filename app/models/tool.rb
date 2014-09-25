class Tool
  include ActiveModel::Model

  attr_accessor :zip_name, :pass, :dir

  validates :dir, :zip_name, presence: true
  #TODO nakao なぜ after_validationでnomethodエラー？
  #after_validation :init

  def save_zip_as_zip
    dest = Rails.root.join('var', 'tmp', 'exported', zip_name + '.zip').to_s.force_encoding('UTF-8')
    Utils.file_field_save(dir, dest)

    src = dest
    dest = Rails.root.join('var', 'tmp', 'zipped', zip_name + '.zip').to_s.force_encoding('UTF-8')
    Utils.zip_to_zip(edit_exported).call(src, dest, nil, pass)
    return dest
  end

  def init
    self.pass = nil if self.pass == ''
    self.zip_name = zip_name.force-encoding('UTF-8')
  end

  private

    def edit_exported
      Proc.new do |src, dest|
        Utils.clean_up(dest)
        Dir.glob(src + '/**/*').each do |path|
          if File.basename(path)[0,1] != '__'
            Utils.copy(path, path.gsub(/#{src}\/.+?(\z|\/)/, dest + $1.to_s))
          end
        end
      end
    end
end