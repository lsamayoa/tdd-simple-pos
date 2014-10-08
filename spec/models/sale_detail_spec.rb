require 'rails_helper'

RSpec.describe SaleDetail, :type => :model do
  it "should calculate subtotal before saving" do
    sale_detail = FactoryGirl.create(:sale_detail)
    expect(sale_detail.reload.subtotal).to eq (sale_detail.quantity * sale_detail.product.price)
  end
end
