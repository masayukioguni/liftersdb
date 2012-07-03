# -*- encoding: utf-8 -*-
require 'spec_helper'

describe "Lifter Model" do
  before do
    @lifter = FactoryGirl.build(:lifter)
    @lifter.save.should be_true
  end

  it "create" do
    @lifter.should be_valid
  end

  it "all" do
    @lifter = Lifter.all
    @lifter.should be_true
  end

  it "update" do
    Lifter.update(:first,:name => "mod_title")
    record = Lifter.find(:first)
    record.name.should == "mod_title"
  end

  it "update japanese" do
    Lifter.update(:first,:name => "コクリコ坂から")
    record = Lifter.find(:first)
    record.name.should == "コクリコ坂から"
  end

  it "name null update == false " do
    record_src = Lifter.find(:first)
    record_src.name = nil
    false == record_src.save()
  end

  it "name null create == false " do
    lifter  = FactoryGirl.build(:lifter ,:name => nil)
    lifter .save.should be_false
  end

  it "insert" do
    lifter  = FactoryGirl.build(:lifter)
    lifter.save.should be_true
  end

  it "delete" do
    id = Lifter.find(:first).id
    Lifter.delete(id)    
    proc {	
	record = Lifter.find(id)
    }.should raise_error(  ActiveRecord::RecordNotFound )
  end

  it "find" do
    record = Lifter.find(:first)
    record.should be_true
  end

  after do
    #Lifter.delete_all
  end
end
