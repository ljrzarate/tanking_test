# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tanking_log do
    car_id 1
    cost 1.5
    date Time.now
    gallon 1.5
    gas_station_id 1
    km 1
  end
end
