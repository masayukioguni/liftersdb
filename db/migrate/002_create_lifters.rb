class CreateLifters < ActiveRecord::Migration
  def self.up
    create_table :lifters do |t|
      t.string :name
      t.integer :gender
      t.datetime :birthday
      t.timestamps
    end
  end

  def self.down
    drop_table :lifters
  end
end
