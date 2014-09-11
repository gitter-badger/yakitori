class Price < ActiveRecord::Base
  has_many :sales
  validates :value, presence: true
end
