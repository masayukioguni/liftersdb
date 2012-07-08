require 'spec_helper'

describe "Record Model" do
  before do
    50.times {
      @record = FactoryGirl.create(:record)
      @record.save.should be_true
    }
  end

  it "create" do
    @record.should be_valid
  end

  after do
    
    #Record.delete_all
  end
end
