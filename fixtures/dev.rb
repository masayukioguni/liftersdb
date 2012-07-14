# -*- encoding: utf-8 -*-
require 'sqlite3'
require 'csv'

def drop(db)
  tables = [
    'championships',
    'lifters',
    'records',
  ]

  tables.each{|name| 
    sql = 'DROP TABLE ' + name + ';'
  	db.execute(sql)
  }

end

def create(db)
  tables = [
	'CREATE TABLE "championships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "date" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);',
	'CREATE TABLE "lifters" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "gender" integer, "birthday" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);',
	'CREATE TABLE "records" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "lifter_id" integer, "championship_id" integer, "equipment" boolean, "weight" float, "squat" float, "benchpress" float, "deadlift" float, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "record_type" integer);',
	]

  tables.each{|sql| 
  	db.execute(sql)
  }
end

championship_datas = [{"name"=>"全日本パワーリフティング選手権大会", "date"=>"2012-06-03"},
                      {"name"=>"埼玉県パワーリフティング選手権大会", "date"=>"2011-11-13"}
        	     ]

def championship(db,datas,at='2012-06-03 00:00:00')
  sql = "insert into championships values (?, ?, ?, ?, ?)"
  datas.each_with_index{|data,index| 
  	db.execute(sql, index + 1, data['name'], data['date'], at, at)
  } 
end  

lifter_datas = [{"name"=>"小国 正之", "gender" => 1, "birthday" => "1980-01-08"},
                {"name"=>"テスト", "gender" => 0, "birthday" => "1999-01-08"}
               ]

def lifter(db,datas,at='2012-06-03 00:00:00')
  sql = "insert into  lifters values (?, ?, ?, ?, ?, ?)"
  datas.each_with_index{|data,index| 
  	db.execute(sql, index + 1, data['name'], data['gender'], data['birthday'], at, at)
  } 
end  

record_datas = [[1,1,1,64.7,227.5,165.0,200,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [2,1,1,64.7,220,172.5,187.5,1],
                [1,2,1,64.7,0,170,0,0]
               ]

def record(db,datas,at='2012-06-03 00:00:00')
  sql = "insert into  records values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
  datas.each_with_index{|data,index| 
    db.execute(sql, index + 1, data[0], data[1], data[2], data[3], data[4], data[5], data[6], at, at,data[7])
  } 
end  


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

def parse_csv(name)
  players = []
  championships = []
  championship = {}
  championship_flag = 0
  CSV.open(name, "r") do |csv|
    csv.each do |row|
      if championship_flag == 0 then
         championship['name'] = row[0]
         championship['date'] = row[1]
         championship_flag = 1
         championships.push(championship) 
         next
      end
      player = {}
      player['name'] = row[0]
      player['gender'] = row[1]
      player['equipment'] = row[2]
      player['record_type'] = row[3]
      player['years'] = row[4]
      player['weight'] = row[5].to_f
      player['sq'] = get_best_result(row,6)
      player['bp'] = get_best_result(row,9)
      player['dl'] = get_best_result(row,12)
      players.push(player)
    end
  end
  return players,championships
end

def insert_championship(db,championship,at='2012-06-03 00:00:00')
  championship_id = 0
  record = db.execute("select * from championships where name = '#{championship['name']}' and date = '#{championship['date']}'")
  if record != []
    championship_id = record[0][0]
  else 
    records = db.execute("select * from championships")
    championship_id = records.size + 1
    p "insert #{championship['name']}  #{championship['date']}"
    sql = "insert into championships values (?, ?, ?, ?, ?)"
    db.execute(sql, championship_id, championship['name'], championship['date'], at, at)
  end
  return championship_id
end  

def insert_player(db,championship_id,player,at='2012-06-03 00:00:00')
  
  lifter_id = 0
  record = db.execute("select * from lifters where name like '%#{player['name']}%' ")
  if record != []
    lifter_id = record[0][0]
  else 
    records = db.execute("select * from lifters")
    lifter_id = records.size + 1
    p "insert lifter #{player['name']}, #{player['gender']}"
    sql = "insert into  lifters values (?, ?, ?, ?, ?, ?)"
    db.execute(sql, lifter_id, player['name'], player['gender'], '1980-06-03', at, at)
  end

  records = db.execute("select * from records")
  record_id = records.size + 1  
  sql = "insert into records values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
  p "insert record #{record_id},#{lifter_id},#{championship_id},#{player['name']},#{player['weight']}"
  db.execute(sql, record_id, lifter_id, championship_id, 
            player['equipment'], player['weight'], player['sq'], 
            player['bp'], player['dl'], at, at,player['record_type'])

end  
pl_datas = ["2012_all_japan_power.csv",
            "2011_all_japan_power_men.csv",
            "2011_all_japan_power_women.csv",
            "2011_all_japan_bench.csv",
            ]
db = SQLite3::Database.new("./db/liftersdb_development.db")
db.transaction
begin
  drop(db)
  create(db)
  championship(db,championship_datas)
  lifter(db,lifter_datas)
  record(db,record_datas)
  players = []
  championships = []
  base_path = "./fixtures/datas/"
  pl_datas.each{ |name| 
    file_path = base_path + name
    players,championships = parse_csv(file_path)
    championship_id = 0
    championships.each{|championship|
      championship_id = insert_championship(db,championship)
    }
    players.each{|player|
      insert_player(db,championship_id,player)
    }
  }
  db.commit
rescue  => exc
  p exc
  db.rollback
end

db.close

