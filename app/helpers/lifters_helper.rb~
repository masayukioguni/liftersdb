# Helper methods defined here can be accessed in any controller or view in the application

Liftersdb.helpers do
  def get_project_name
    return 'Lifters db'
  end

  def find_by_lifter_id(lifter_id)
    return Record.joins(:championship).where(:lifter_id => lifter_id)
  end

  def find_by_gender_equipment_type(lifter_id,equipment,record_type)
    return find_by_lifter_id(lifter_id).where(:equipment => equipment,
       	                                      :record_type => record_type)
  end

  def find_by_gender(gender) 
    lifter = Lifter.joins(:record)
    return lifter.where(:gender => gender)
  end

  def parse_request_params(params)
    equipment = params[:equipment] ? params[:equipment] : 1
    type = params[:type] ? params[:type] : 1
    gender = params[:gender] ? params[:gender] : 1
    return gender,equipment,type
  end
end
