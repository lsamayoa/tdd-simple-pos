class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = policy_scope(Product).all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = current_user.products.create(product_params)
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private
    def set_and_authorize_product
      set_product
      authorize_product
    end

    def authorize_product
      authorize @product
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
