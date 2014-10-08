require 'rails_helper'

RSpec.describe Sale, :type => :model do  

  describe "Validations" do
    it "should not allow to create a sale without a client" do
      expect {
        FactoryGirl.create(:sale_without_client)
      }.to raise_error ActiveRecord::RecordInvalid
    end  

    it "should not allow to create a sale without a seller" do
      expect {
        FactoryGirl.create(:sale_without_seller)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should not allow to create a sale without sale details" do
      expect {
        FactoryGirl.create(:sale_without_sale_details)
      }.to raise_error ActiveRecord::RecordInvalid
    end    
  end

  it "should calculate total before validating" do
    sale = FactoryGirl.build(:sale_with_known_total)
    sale.save
    expect(sale.reload.total).to eq 100
  end
  
end
