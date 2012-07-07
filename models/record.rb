class Record < ActiveRecord::Base
  belongs_to :lifter
  belongs_to :championship
  
  validates :lifter_id, :presence => true
  validates :championship_id, :presence => true
  validates :equipment, :presence => true
  validates :weight, :presence => true
  validates :squat, :presence => true
  validates :benchpress, :presence => true
  validates :deadlift, :presence => true
end
