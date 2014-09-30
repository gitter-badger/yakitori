class Sale < ActiveRecord::Base
  belongs_to :task
  has_many :sale_products
  has_many :products, :through => :sale_products  
  belongs_to :price
  belongs_to :sale_category
  before_create :set_default_value

  attr_accessor :thumbnail_file, :preview1_file, :preview2_file, :preview3_file, :preview4_file, :preview5_file

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

  private

    def set_default_value
      self.description ||= nil
      self.visible ||= true
      self.area ||= SALE_AREA_RED
      self.optimum_plan ||= STANDARD_PLAN_RED
      self.task_id = nil
    end
end
