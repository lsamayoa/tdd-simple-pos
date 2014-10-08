require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :user, presence: true

  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0

  belongs_to :user

  after_create :generate_barcode

  before_validation :set_stock_if_missing, :set_price_if_missing

  private
    def set_stock_if_missing
      self.stock ||= 0
    end

    def set_price_if_missing
      self.price ||= 0
    end

    def generate_barcode
      barcode = Barby::Code128.new("#{self.id.to_s.rjust(10, '0')}")
      barcode_path = Rails.public_path.join('images', 'products', 'barcodes', "#{self.id.to_s.rjust(10, '0')}.png").to_s
      barcode_img = Barby::PngOutputter.new(barcode).to_image
      barcode_img.save barcode_path
      self.barcode_path = barcode_path
      self.save!
    end

end
