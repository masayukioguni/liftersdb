FactoryGirl.define do
  factory :record do
    lifter_id { 
     	lifter = FactoryGirl.create(:lifter)
        lifter.id
    }
    championship_id { 
     	championship = FactoryGirl.create(:championship)
        championship.id
    }
    equipment { Random.boolean() }
    weight { Random.new.rand(100) }
    squat  { Random.new.rand(440) }
    benchpress { Random.new.rand(360) }
    deadlift { Random.new.rand(500) }
  end
end