require 'rails_helper'
include Warden::Test::Helpers

module RequestHelpers
  def user
    @user
  end

  def login
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
end