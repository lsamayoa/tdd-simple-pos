require 'rails_helper'

RSpec.describe SalesService, :type => :model do
  
  describe "Product selling" do
    it "should reduce the stock of all sold products" do
      product = create(:owned_product, stock: 100)
      sell_with_product(product, 30)
      expect(product.reload.stock).to be 70
    end

    it "should create a sale in the database" do
      expect {
        valid_sell
      }.to change(Sale, :count).by(1)
    end

    it "should return a sale if succeeds" do
      sale = valid_sell
      expect(sale).to be_a(Sale)
      expect(sale).to be_persisted
    end

    it "should persist the sale details" do
      sale_detail = build(:sale_detail)
      expect {
        valid_sell
      }.to change(SaleDetail, :count).by(1)
    end

    it "should associate the sale details to the sale" do
      sale_detail = build(:sale_detail)
      sale = sell_with_sale_detail(sale_detail)
      expect(sale.reload.sale_details.count).to eq 1
      expect(sale_detail.reload).to eq sale.reload.sale_details[0]
    end

    it "should associate seller to the sale" do
      seller = create(:employee)
      sale = sell_with_seller(seller)
      expect(sale.reload.seller).to eq seller
    end

    it "should client seller to the sale" do
      client = create(:client)
      sale = sell_with_client(client)
      expect(sale.reload.client).to eq client
    end

    private 
      def valid_sell
        sale_detail = build(:sale_detail)
        seller = create(:employee)
        client = create(:client)
        sell(seller, client, sale_detail)
      end

      def sell_with_product(product, quantity = 1)
        sale_detail = build(:sale_detail, product: product, quantity: quantity)
        sell_with_sale_detail(sale_detail)
      end

      def sell_with_sale_detail(sale_detail)
        seller = create(:employee)
        client = create(:client)
        sell(seller, client, sale_detail)
      end

      def sell_with_seller(seller)
        sale_detail = build(:sale_detail)
        client = create(:client)
        sell(seller, client, sale_detail)
      end

      def sell_with_client(client)
        sale_detail = build(:sale_detail)
        seller = create(:employee)
        sell(seller, client, sale_detail)
      end

      def sell(seller, client, sale_detail)
        SalesService.sell(seller, client, [sale_detail])
      end

  end

end