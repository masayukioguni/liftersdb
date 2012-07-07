require 'spec_helper'

describe "Record Model" do
  before do
  	lifter_id = Lifter.find(:first).id
    cs_id = Championship.find(:first).id
    p lifter_id
    p cs_id
    @record = FactoryGirl.build(:record, :lifter_id => lifter_id, :championship_id => cs_id)
    p @record
    @record.save.should be_true
  end

  it "create" do
    @record.should be_valid
  end
end
