# -*- encoding: utf-8 -*-
# Helper methods defined here can be accessed in any controller or view in the application
Liftersdb.helpers do

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
      records= lifter.record.where(:lifter_id => lifter.id,:equipment => equipment,:record_type => record_type)
      records = records.joins(:championship)
      records.order('championships.date DESC').limit(1).each{|record|
        lifter_record = {
              'id' => lifter.id,
              'class_name' => get_men_class_name(record.weight),
              'name' => lifter.name,
              'weight' => record.weight,
              'total' => record.total,
              'date' => record.championship.date
        }
        lifters_record.push(lifter_record)
      }
    }
    return lifters_record
  end

  def record_to_powerlifting_csv(records)
    text = "date,weight,squat,bencpress,deadlift,total\n";
    records.each{|record|
      text += record.championship.date.to_s
      text += ","
      text += record.weight.to_s
      text += ","
      text += record.squat.to_s
      text += ","
      text += record.benchpress.to_s
      text += ","
      text += record.deadlift.to_s
      text += ","
      text += record.total.to_s
      text += "\n"
    }
    return text
  end 

  def get_template_name(record_type)
    template_array = ['benchpress','powerlifting']
    return template_array[record_type.to_i]
  end

  def record_to_benchpress_csv(records)
    text = "date,weight,bencpress\n";
    records.each{|record|
      text += record.championship.date.to_s
      text += ","
      text += record.weight.to_s
      text += ","
      text += record.benchpress.to_s
      text += "\n"
    }
    return text
  end

  def record_to_csv(record_type,records) 
    if Recordtype.is_powerlifting(record_type)
      return record_to_powerlifting_csv(records)
    end

    if Recordtype.is_benchpress(record_type)
      return record_to_benchpress_csv(records)
    end
  end

  def parse_request_params(params)
    equipment = params[:equipment] ? params[:equipment].to_i : 1
    type = params[:type] ? params[:type].to_i : 1
    gender = params[:gender] ? params[:gender].to_i : 1
    return gender,equipment,type
  end
end
