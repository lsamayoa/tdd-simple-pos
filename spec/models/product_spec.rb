require 'rails_helper'

RSpec.describe Product, :type => :model do
  describe "Validations" do
    it "should not allow for a product to have a negative price" do
      expect{
        product = FactoryGirl.create(:owned_product, price: -40)
      }.to raise_error ActiveRecord::RecordInvalid
    end
    it "should not allow for a product without owner" do
      expect{
        FactoryGirl.create(:product)
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe "Default data" do
    it "should assign 0 as cost if it wasn't assigned" do
      product = FactoryGirl.build(:owned_product)
      product.price = nil
      product.save
      expect(product.reload.price).to eq 0
    end

    it "should assign 0 as stock if it wasn't assigned" do
      product = FactoryGirl.build(:owned_product)
      product.stock = nil
      product.save
      expect(product.reload.stock).to eq 0
    end
  end

  describe "Inventory keeping" do
    it "should allow to add stock to the product" do
      product = FactoryGirl.create(:owned_product)
      product.stock = 50
      product.save
      expect(product.reload.stock).to be 50
    end
  end

  describe "Barcodes" do
    it "should generate a barcode for a newly created product" do
      product = FactoryGirl.create(:owned_product)
      image_path = Rails.public_path.join('images', 'products', 'barcodes', "#{product.id.to_s.rjust(10, '0')}.png").to_s
      
      expect(product.barcode_path).to eq image_path
      expect(File.exist?(image_path)).to be true
    end
  end
end
