require 'rails_helper'

RSpec.describe Client, :type => :model do
  describe "Validations" do
    it "should not allow for a client without first name" do
      expect{
        FactoryGirl.create(:client_without_first_name)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should not allow for a client without last name" do
      expect{
        FactoryGirl.create(:client_without_last_name)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should not allow for a client without user" do
      expect{
        FactoryGirl.create(:client_without_user)
      }.to raise_error ActiveRecord::RecordInvalid
    end

  end
end
