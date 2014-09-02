class Price < ActiveRecord::Base
  validates :value, presence: true
end
