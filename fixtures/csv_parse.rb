require 'rubygems'
require 'csv'


def get_best_result(row,index)
  value = 0
  index.upto(index + 2) { |i|
    tmp = row[i]
    if tmp != " "
      if tmp.to_f > 0
        value = tmp.to_f
      end
    end
  }
  return value
end

championship_flag = 0
players = []
championship = {}

pl_datas = {"2012_all_japan_.csv",
            "2011_all_japan_power_men.csv",
            }

def csv_parse(name)
  CSV.open(name, "r") do |csv|
    csv.each do |row|
      if championship_flag == 0 then
         championship['name'] = row[0]
         championship['date'] = row[1]
         championship_flag = 1
         next
      end
      player = {}
      player['name'] = row[0]
      player['gender'] = row[1]
      player['years'] = row[2]
      player['weight'] = row[3].to_f
      # 4/5/6
      player['sq'] = get_best_result(row,4)
      # 7/8/9
      player['bp'] = get_best_result(row,7)
      # 10/11/12
      player['dl'] = get_best_result(row,10)
      players.push(player)
    end
  end
end



p championship
p players

// 