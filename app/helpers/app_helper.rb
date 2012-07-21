# -*- encoding: utf-8 -*-
# Helper methods defined here can be accessed in any controller or view in the application
Liftersdb.helpers do
  def get_project_name
    p Admin.foo
    return 'データベース'
  end

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

    def Recordtype.is_powerlifting(type) 
      return type == Recordtype.pl
    end

    def Recordtype.is_benchpress(type) 
      return type == Recordtype.bp
    end
  end

  def get_women_class_name(weight)
    if weight <= 59 then return '59kg' end
    if weight <= 66 then return '66kg' end
    if weight <= 74 then return '74kg' end
    if weight <= 83 then return '83kg' end
    if weight <= 93 then return '93kg' end
    if weight <= 105 then return '105kg' end
    if weight <= 120 then return '120kg' end
    if weight >= 120.1 then return '120kg+' end
  end

  def get_men_class_name(weight)
    if weight <= 59 then return '59kg' end
    if weight <= 66 then return '66kg' end
    if weight <= 74 then return '74kg' end
    if weight <= 83 then return '83kg' end
    if weight <= 93 then return '93kg' end
    if weight <= 105 then return '105kg' end
    if weight <= 120 then return '120kg' end
    if weight >= 120.1 then return '120kg+' end
  end
  
  def get_gender_text(gender)
    if gender == Gender.men
      return "男子"
    elsif gender == Gender.women
      return "女子"
    else
      return "不明"
    end
  end

  def get_equipment_text(equipment)
    if equipment == Equipment.yes
      return "フルギア"
    elsif equipment == Equipment.no
      return "ノーギア"
    else
      return "不明"
    end
  end

  def get_type_text(record_type)
    if Recordtype.is_powerlifting(record_type)
      return "パワーリフティング"
    elsif Recordtype.is_benchpress(record_type)
      return "ベンチプレス"
    else
      return "不明"
    end
  end

  def get_title(gender,equipment,record_type)
    return get_gender_text(gender) + "/" + get_type_text(record_type) + "/" + get_equipment_text(equipment)
  end
end
