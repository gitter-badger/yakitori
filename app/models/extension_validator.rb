class ExtensionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    seed = ''
    options[:white_list].each do |ext|
      seed << ext
      seed << '|' unless ext == options[:white_list].last
    end

    if options[:white_list].length == 0 || value.original_filename !~ Regexp.new("\\.(#{seed})\\z", Regexp::IGNORECASE)
      record.errors[attribute] << (options[:message] || 'の拡張子が不正です。')
    end
  end
end