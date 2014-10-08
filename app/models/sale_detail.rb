class SaleDetail < ActiveRecord::Base
  validates_presence_of :quantity, :product
  validates_numericality_of :quantity, greater_than_or_equal_to: 1

  belongs_to :sale
  belongs_to :product

  before_validation :calculate_subtotal

  private
    def calculate_subtotal
      self.subtotal = self.product.price * self.quantity 
    end
end
