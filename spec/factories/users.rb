# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "leonel.e.samayoa#{n}@gmail.com" }
    password "leo010170"
  end
end