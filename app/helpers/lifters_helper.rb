# Helper methods defined here can be accessed in any controller or view in the application

Liftersdb.helpers do
  def get_project_name
    return 'Lifters db'
  end

  def find_by_lifter_id(lifter_id)
    return Record.joins(:championship).where(:lifter_id => lifter_id).order('championships.date')
  end

  def find_by_equipment_type(lifter_id,equipment,record_type)
    return find_by_lifter_id(lifter_id).where(:equipment => equipment,:record_type => record_type)
  end

end
