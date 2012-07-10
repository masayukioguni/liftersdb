class AddRecordtypeToRecord < ActiveRecord::Migration
  def self.up
    change_table :records do |t|
      t.integer :record_type
    end
  end

  def self.down
    change_table :records do |t|
      t.remove :record_type
    end
  end
end
