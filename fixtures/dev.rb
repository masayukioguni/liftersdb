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
        	      [1,2,1,64.7,220,172.5,187.5,1],
        	      [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
                [1,1,1,64.7,227.5,165.0,200,1],
                [1,2,1,64.7,220,172.5,187.5,1],
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

championship_flag = 0
players = []
championship = {}

CSV.open("./fixtures/datas/2012_all_japan_.csv", "r") do |csv|
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

def insert(db,championship,players,at='2012-06-03 00:00:00')
  sql = "select * from championships WHERE name LIKE '%#{championship['name']}%'"
  count = db.execute(sql)
  if [] == count then
    sql = "insert into championships values (?, ?, ?, ?, ?)"
    db.execute(sql, 1, championship['name'], championship['date'], at, at)
  end
end  

db = SQLite3::Database.new("./db/liftersdb_development.db")
db.transaction
begin
  drop(db)
  create(db)
  insert(db,championship,players)
  #championship(db,championship_datas)

  #lifter(db,lifter_datas)
  #record(db,record_datas)
  db.commit
rescue  => exc
  p exc
  db.rollback
end

db.close

