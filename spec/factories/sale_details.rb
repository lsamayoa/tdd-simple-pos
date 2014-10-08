# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sale_detail do
    quantity 1
    product { FactoryGirl.create(:owned_product) }
    
    factory :sale_detail_with_product do
      ignore do
        product_price 10
      end
      after(:build) do |detail, evaluator|
        detail.product =  FactoryGirl.create(:owned_product, price: evaluator.product_price)
      end
    end

  end
end
