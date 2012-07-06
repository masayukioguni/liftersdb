class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.integer :lifter_id
      t.integer :championship_id
      t.boolean :equipment
      t.float :weight
      t.float :squat
      t.float :benchpress
      t.float :deadlift
      t.timestamps
    end
  end

  def self.down
    drop_table :records
  end
end
