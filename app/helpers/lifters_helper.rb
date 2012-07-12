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

  def find_by_lifter_list(gender,equipment,record_type)
    lifters_record = []
    lifters = Lifter.where(:gender => gender).each{|lifter|
      best_total = 0
      best_weight = 0
      lifter.record.where(:lifter_id => lifter.id,:equipment => equipment,:record_type => record_type).each{|record|
        total = record.total
        if total > best_total
          best_total = total
          best_weight = record.weight
        end
      }
      record = {
            'name' => lifter.name,
            'weight' => best_weight,
            'total' => best_total
      }
      lifters_record.push(record)
    }
    return lifters_record
  end

  def parse_request_params(params)
    equipment = params[:equipment] ? params[:equipment] : 1
    type = params[:type] ? params[:type] : 1
    gender = params[:gender] ? params[:gender] : 1
    return gender,equipment,type
  end
end
