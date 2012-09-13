# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :car do
    sequence(:brand) {|c| "Mungstang #{c}"}
    sequence(:model) {|c| "Model #{c}"}
    sequence(:year)  {|c| "201#{c}".to_i}
    sequence(:color) {|c| "color - #{c}"}
  end


  factory :car_current_year, parent: :car do
    sequence(:brand) {|c| "Mungstang #{c}"}
    sequence(:model) {|c| "Model #{c}"}
    year Time.now.year
    sequence(:color) {|c| "color - #{c}"}
  end

  factory :car_nil, parent: :car do
    brand nil
    model nil
    year nil
    color nil
  end

  factory :static_car, parent: :car do
    brand "BMW"
    model "ASD"
    year "2012"
    color "blue"
  end

end
