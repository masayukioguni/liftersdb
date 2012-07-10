# -*- encoding: utf-8 -*-
require 'sqlite3'

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
		      {"name"=>"全日本パワーリフティング選手権大会", "date"=>"2012-06-03"},
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
        	[2,1,1,64.7,220,172.5,187.5,1],
                [1,2,1,64.7,0,170,0,0]
               ]

def record(db,datas,at='2012-06-03 00:00:00')
  sql = "insert into  records values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
  datas.each_with_index{|data,index| 
  	db.execute(sql, index + 1, data[0], data[1], data[2], data[3], data[4], data[5], data[6], at, at,data[7])
  } 
end  

db = SQLite3::Database.new("./db/liftersdb_development.db")
db.transaction
begin
  drop(db)
  create(db)
  championship(db,championship_datas)
  lifter(db,lifter_datas)
  record(db,record_datas)
  db.commit
rescue  => exc
  p exc
  db.rollback
end

db.close

