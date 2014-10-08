require 'rails_helper'
require 'support/request_helpers'

include RequestHelpers

feature "Product creation" do
  let(:authed_user){ create_logged_in_user }
  # Login before each test
  before(:each) { @user = authed_user}

  scenario "succesfully creates a product" do
    product_name = "Test Product"
    product_description = "Lorem Ipsum"
    product_price = 35
    
    create_product product_name, product_description, product_price

    expect(page).to have_content product_name
  end

  def create_product(product_name, product_description, product_price)
    visit root_path
    click_link "Products"
    click_link "New Product"
    fill_in "Name", with: product_name
    fill_in "Description", with: product_description
    fill_in "Price", with: product_price
    click_button "Create Product"
  end

end