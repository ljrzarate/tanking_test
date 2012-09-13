# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"

FactoryGirl.define do
  factory :user do
  	name { Faker::Name.first_name}
  	email   "luis.rodriguez@koombea.com"
    password "foobar"
    password_confirmation "foobar"
    remember_me true
  end
end