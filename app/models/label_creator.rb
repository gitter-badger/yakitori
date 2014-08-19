class LabelCreator < ActiveRecord::Base

  #本番DBより持ってくる最新のLABEL
  NOW_PAY_LABELS = {
    "1" => "1000",
    "2" => "2000",
    "3" => "3000",
    "4" => "4000",
    "5" => "5000",
    "6" => "6000",
    "7" => "7000",
    "8" => "8000"
  }

  NOW_FREE_LABELS = {
    "1" => "F10000",
    "2" => "F20000",
    "3" => "F30000",
    "4" => "F40000",
    "5" => "F50000",
    "6" => "F60000",
    "7" => "F70000",
    "8" => "F80000"
  }

  def self.getNextLabel(genre, category)
    return countUp(getNowLabel(genre, category))
  end

  def self.getNowLabel(genre, category)
    begin
      return Product.where(genre_id: genre).order("label DESC").first.label.force_encoding("UTF-8")
    rescue
      #ActiveRecord::RecordNotFound
      return (category == "0") ? NOW_FREE_LABELS[genre] : NOW_PAY_LABELS[genre]
    end
  end

  def self.countUp(label)
    if (label[0, 1] == "F")
      num = label[1, 5].to_i(10)
      return "F" + (num + 1).to_s(10)
    else
      num = label[1, 3].hex
      return (num + 1).to_s(16)
    end
  end
end
