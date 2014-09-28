#Custom MethodによるValidationの共通化も考えたが、
#その場合、Model内でシンボルでValudate Methodを指定しないといけないため
#Model内にMethodを個別に持たせないといけないため共通化は難しい。

class ExtensionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    seed = ''
    options[:white_list].each do |ext|
      seed << ext
      seed << '|' unless ext == options[:white_list].last
    end

    #正規表現のエスケープに関して参考 => http://neareal.net/index.php?Programming%2FRuby%2FDifference%20between%20Regexp.new%20and%20slash%20pattern
    if options[:white_list].length == 0 || value.original_filename !~ Regexp.new("\\.(#{seed})\\z", Regexp::IGNORECASE)
      record.errors[attribute] << (options[:message] || 'の拡張子が不正です。')
    end
  end
end