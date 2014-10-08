# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    first_name "Leonel"
    last_name "Samayoa"
    email "leonel.e.samayoa@gmail.com"
    user { FactoryGirl.create(:user) }

    factory :client_without_first_name do
      first_name nil
    end

    factory :client_without_last_name do
      last_name nil
    end

    factory :client_without_email do
      email nil
    end

    factory :client_without_user do
      user nil
    end
  end
end
