# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sale do
    client { FactoryGirl.create(:client) }
    seller { FactoryGirl.create(:employee) }
    sale_details { [FactoryGirl.create(:sale_detail)] }

    factory :sale_without_client do
      client nil  
    end

    factory :sale_with_known_total do
      after(:build) do |sale|
        sale.sale_details = create_list(:sale_detail_with_product, 1, quantity: 10, sale: sale)
      end
    end

    factory :sale_without_seller do
      seller nil
    end

    factory :sale_without_sale_details do
      sale_details []
    end
  end
end
