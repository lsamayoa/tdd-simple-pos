require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "Associations" do
    it "should have clients" do
      expect(User.new).to respond_to(:clients)
    end
    it "should have products" do
      expect(User.new).to respond_to(:products)
    end
  end
end
