class Championship < ActiveRecord::Base
  has_many :record
  validates :name, :presence => true
  validates :date, :presence => true
end
