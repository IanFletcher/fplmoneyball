# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gameweek do
    start_date "2014-02-04 18:09:23"
    end_date "2014-02-04 18:09:23"
    open false
    closed false
    current false
    status "Future"
  end
end
