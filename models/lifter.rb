class Lifter < ActiveRecord::Base
  has_many :record
  validates :name, :presence => true
  validates :gender, :presence => true
end
