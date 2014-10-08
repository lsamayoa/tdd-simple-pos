class SalesService
  def self.sell(seller, client, sale_details)
    ActiveRecord::Base.transaction do
      sale = Sale.new
      sale_details.each do |sale_detail|
        product = sale_detail.product
        product.stock -= sale_detail.quantity
        product.save!
        sale.sale_details << sale_detail
      end
      sale.seller = seller
      sale.client = client
      sale.save!
      sale
    end
  end
end