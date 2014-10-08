FactoryGirl.define do
  factory :product do
    name "Test Product"
    description "Lorem Ipsum"
    price 35.55
    stock 100
  end
  factory :owned_product, :class => 'Product' do
    name "Test Product"
    description "Lorem Ipsum"
    price 35.55
    stock 100
    user { FactoryGirl.create(:user) }
  end
end
