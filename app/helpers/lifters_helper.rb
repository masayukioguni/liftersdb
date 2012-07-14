# Helper methods defined here can be accessed in any controller or view in the application
Liftersdb.helpers do
  class Gender
    def Gender.men
      return 1
    end
    def Gender.women
      return 0
    end
  end

  class Equipment
    def Equipment.yes
      return 1
    end
    def Equipment.no
      return 0
    end
  end

  class Recordtype
    def Recordtype.pl
      return 1
    end
    def Recordtype.bp
      return 0
    end
  end

  def get_men_class_name(weight)
    p weight
    if weight <= 59 then return '59kg' end
    if weight <= 66 then return '66kg' end
    if weight <= 74 then return '74kg' end
    if weight <= 83 then return '83kg' end
    if weight <= 93 then return '93kg' end
    if weight <= 105 then return '105kg' end
    if weight <= 120 then return '120kg' end
    if weight >= 120.1 then return '120kg+' end
  end
  
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
    lifters = Lifter.where(:gender => gender).order("id").each{|lifter|
      best_total = 0
      best_weight = 0
      lifter.record.where(:lifter_id => lifter.id,:equipment => equipment,:record_type => record_type).order("id").each{|record|
        total = record.total
        if total > best_total
          best_total = total
          best_weight = record.weight
        end
      }
      if best_total != 0
        record = {
              'id' => lifter.id,
              'class_name' => get_men_class_name(best_weight),
              'name' => lifter.name,
              'weight' => best_weight,
              'total' => best_total
        }
        lifters_record.push(record)
      end
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
