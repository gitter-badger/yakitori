class Sale < ActiveRecord::Base
  belongs_to :task
  has_many :sale_products
  has_many :products, :through => :sale_products  
  belongs_to :price
  belongs_to :sale_category
  before_create :set_default_value

  attr_accessor :thumbnail_file, :preview1_file, :preview2_file, :preview3_file, :preview4_file, :preview5_file, :product_id

  validates :name, :price_id,:sale_category_id, :display_order, :is_new, presence: true
  validates :thumbnail_file, :preview1_file, presence: true, on: :create
  validates :name, allow_blank: true, uniqueness: true
  validates :price_id, :sale_category_id, :display_order, allow_blank: true, numericality: true
  validates :thumbnail_file, allow_blank: true, extension: {:white_list => %w(bmp gif jpg jpeg png)}
  validates :preview1_file, allow_blank: true, extension: {:white_list => %w(bmp gif jpg jpeg png)}
  validates :preview2_file, allow_blank: true, extension: {:white_list => %w(bmp gif jpg jpeg png)}
  validates :preview3_file, allow_blank: true, extension: {:white_list => %w(bmp gif jpg jpeg png)}
  validates :preview4_file, allow_blank: true, extension: {:white_list => %w(bmp gif jpg jpeg png)}
  validates :preview5_file, allow_blank: true, extension: {:white_list => %w(bmp gif jpg jpeg png)}

  SALE_AREA_RED = 0
  SALE_AREA_BLUE = 1

  ENTRY_PLAN_RED = 0
  STANDARD_PLAN_RED = 1
  PREMIUM_PLAN_RED = 2
  RIGHT_PLAN_BLUE = 3
  PRO_PLAN_BLUE = 4

  def price_choices
    Price.pluck(:value, :id)
  end

  def sale_category_choices
    SaleCategory.pluck(:name, :id)
  end

  def is_new_choices
    [['新着フラグをだす', true],
     ['新着フラグをださない', false]]
  end

  def sql
    'INSERT INTO mtb_sale VALUES'\
      + "('#{label_id}', '#{name}', NULL, #{Price.find(price_id).value}, '#{SaleCategory.find(sale_category_id).label}', "\
      + "#{display_order}, #{thumbnail_url}, #{form(preview1_url)}, #{form(preview2_url)}, #{form(preview3_url)}, "\
      + "#{form(preview4_url)}, #{form(preview5_url)}, true, true, #{is_new}, 0, '2');"
  end

  private

    def next_label
      count_up current_label
    end

    def count_up(label)
      counter = label[-5, 5].to_i(10)
      SaleCategory.find(sale_category_id).label + format('%05d', counter + 1)
    end

    def current_label
      first = Sale.where(sale_category_id: sale_category_id).order('label_id DESC').first
      if first
        first.label_id
      else
        SaleCategory.where(id: sale_category_id).pluck(:last_id).first
      end
    end

    def set_default_value
      self.label_id = next_label
      self.description ||= nil
      self.visible ||= true
      self.area ||= SALE_AREA_RED
      self.optimum_plan ||= PREMIUM_PLAN_RED
      self.task_id = nil
    end

    def form(value)
      if value == nil || value == ''
        'NULL'
      else
        "'#{value}'"
      end
    end
end
