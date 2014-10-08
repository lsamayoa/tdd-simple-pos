require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  controller do
    def index
      error = Pundit::NotAuthorizedError.new 
      error.policy = ApplicationPolicy.new(nil, nil)
      error.query = "index?"
      raise error
    end
  end

  describe "Authorization Error Handling" do
    it "should rescue from Pundit::NotAuthorizedError" do
      expect{
        get :index
      }.not_to raise_error
    end

    it "should should set the error flash message based on the policy that threw the error" do
      get :index
      expect(flash[:error]).to eq "You cannot perform the index action."
    end

    it "should redirect to the last visited path or back to the root" do
      get :index
      expect(response).to redirect_to(request.referrer || root_path)
    end

  end

end