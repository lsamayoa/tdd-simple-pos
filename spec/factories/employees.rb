# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    first_name "Leonel"
    last_name "Samayoa"
    salary "2000"
    user { FactoryGirl.create(:user) }
  end
end
