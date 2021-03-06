FactoryGirl.define do
  factory :lifter do
    name { Faker::Japanese::Name.name }
    gender { Random.number(2) }
    birthday { Random.date(1000) }
  end
end