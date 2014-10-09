require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  controller do
    def not_authorized_error
      error = Pundit::NotAuthorizedError.new 
      error.policy = ApplicationPolicy.new(nil, nil)
      error.query = "index?"
      raise error
    end
    def param_missing
      raise ActionController::ParameterMissing.new("parameter")
    end
  end

  before do
    routes.draw do
      get "not_authorized_error" => "anonymous#not_authorized_error"
      get "param_missing" => "anonymous#param_missing" 
    end
  end

  describe "Strong parameter handling" do

    it "should rescue from ActionController::ParameterMissing" do
      expect{
        get :param_missing
      }.not_to raise_error
    end

    it "should should set the error flash message based on the parameter that is missing" do
      get :param_missing
      expect(flash[:error]).to eq "parameter is missing."
    end

    it "should redirect to the last visited path or back to the root" do
      get :param_missing
      expect(response).to redirect_to(request.referrer || root_path)
    end
  end

  describe "Authorization Error Handling" do
    it "should rescue from Pundit::NotAuthorizedError" do
      expect{
        get :not_authorized_error
      }.not_to raise_error
    end

    it "should should set the error flash message based on the policy that threw the error" do
      get :not_authorized_error
      expect(flash[:error]).to eq "You cannot perform the index action."
    end

    it "should redirect to the last visited path or back to the root" do
      get :not_authorized_error
      expect(response).to redirect_to(request.referrer || root_path)
    end
  end

end