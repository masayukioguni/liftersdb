# -*- encoding: utf-8 -*-
require 'spec_helper'

describe "Championship Model" do
  before do
    @championship = FactoryGirl.build(:championship)
    @championship.save.should be_true
  end

  it "create" do
    @championship.should be_valid
  end

  it "all" do
    @championship = Lifter.all
    @championship.should be_true
  end

  it "update" do
    Championship.update(:first,:name => "mod_title")
    record = Championship.find(:first)
    record.name.should == "mod_title"
  end

  it "update japanese" do
    Championship.update(:first,:name => "コクリコ坂から")
    record = Championship.find(:first)
    record.name.should == "コクリコ坂から"
  end

  it "name null update == false " do
    record_src = Championship.find(:first)
    record_src.name = nil
    false == record_src.save()
  end

  it "name null create == false " do
    championship  = FactoryGirl.build(:championship ,:name => nil)
    championship .save.should be_false
  end

  it "insert" do
    championship  = FactoryGirl.build(:championship)
    championship.save.should be_true
  end

  it "delete" do
    id = Championship.find(:first).id
    Championship.delete(id)    
    proc {	
	record = Championship.find(id)
    }.should raise_error(  ActiveRecord::RecordNotFound )
  end

  it "find" do
    record = Championship.find(:first)
    record.should be_true
  end

  it "date null update == false " do
    record_src = Championship.find(:first)
    record_src.date = nil
    false == record_src.save()
  end

  it "date null create == false " do
    championship  = FactoryGirl.build(:championship ,:date => nil)
    championship .save.should be_false
  end

  after do
    #Championship.delete_all
  end
end
