class Sale < ActiveRecord::Base
  validates_numericality_of :total, greater_than_or_equal_to: 0
  validates_presence_of :seller
  validates_presence_of :client
  validates_length_of :sale_details, minimum: 1

  belongs_to :client
  belongs_to :seller, class_name: 'Employee'
  has_many :sale_details

  before_validation :calculate_total


  private
    def calculate_total
      self.total = self.sale_details.reduce(0) do |sum, detail|
        subtotal = detail.subtotal || 0
        sum + subtotal
      end
    end

end