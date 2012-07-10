class Record < ActiveRecord::Base
  belongs_to :lifter
  belongs_to :championship
  
  validates :lifter_id, :presence => true
  validates :championship_id, :presence => true
  validates :weight, :presence => true
  validates :squat, :presence => true
  validates :benchpress, :presence => true
  validates :deadlift, :presence => true
  
  def total()
    squat + benchpress + deadlift
  end

  def formula()
     weight * total
  end

  def find_by_lifter_id(lifter_id)
    records = Record.joins(:championship)
    return records.where(:lifter_id => lifter_id).order('championships.date')
  end

  def find_by_equipment_powerlifing(lifter_id)
    records = find_by_lifter_id(lifter_id)
    records.where(:equipment => 1)
    return records.all
  end

end
