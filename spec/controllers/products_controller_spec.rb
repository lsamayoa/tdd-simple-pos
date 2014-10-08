require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:product)
  }

  let(:invalid_attributes) {
    {
      dodo: "dasd",
      dada: "dada"
    }
  }

  let(:valid_session) { {} }

  describe "Authenticated" do
     
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    def create_logged_user_product
      FactoryGirl.create(:product, user: @user)
    end

    describe "GET index" do
      it "assigns current logged in user's products as @products" do
        user_product =  create_logged_user_product
        extranger_product = FactoryGirl.create(:owned_product)
        get :index, {}, valid_session
        expect(assigns(:products)).to eq([user_product])
      end
    end

    describe "GET show" do
      describe "does not own the product" do
        it "returns not found response if user is trying to access products out of his scope" do
          product = FactoryGirl.create(:owned_product)
          get :show, {:id => product.to_param}, valid_session
          expect(response).to have_http_status(:not_found)
        end
      end

      describe "owns the product" do
        it "assigns the requested product as @product" do
          product = create_logged_user_product
          get :show, {:id => product.to_param}, valid_session
          expect(assigns(:product)).to eq(product)
        end  
      end
    end

    describe "GET new" do
      it "assigns a new product as @product" do
        get :new, {}, valid_session
        expect(assigns(:product)).to be_a_new(Product)
      end
    end

    describe "GET edit" do
      it "assigns the requested product as @product" do
        product = create_logged_user_product
        get :edit, {:id => product.to_param}, valid_session
        expect(assigns(:product)).to eq(product)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Product" do
          expect {
            post :create, {:product => valid_attributes}, valid_session
          }.to change(Product, :count).by(1)
        end

        it "sets the logged user as owner of the product" do
          post :create, {:product => valid_attributes}, valid_session
          expect(assigns(:product).user_id).to eq(@user.id) 
        end

        it "assigns a newly created product as @product" do
          post :create, {:product => valid_attributes}, valid_session
          expect(assigns(:product)).to be_a(Product)
          expect(assigns(:product)).to be_persisted
        end

        it "redirects to the created product" do
          post :create, {:product => valid_attributes}, valid_session
          expect(response).to redirect_to(Product.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved product as @product" do
          post :create, {:product => invalid_attributes}, valid_session
          expect(assigns(:product)).to be_a_new(Product)
        end

        it "re-renders the 'new' template" do
          post :create, {:product => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          {
            name: "Updated Product",
            price: 50,
            description: "Lorem Product Mod"
          }
        }

        it "updates the requested product" do
          product = create_logged_user_product
          put :update, {:id => product.to_param, :product => new_attributes}, valid_session
          product.reload
          expect(product.name).to eq("Updated Product")
        end

        it "assigns the requested product as @product" do
          product = create_logged_user_product
          put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
          expect(assigns(:product)).to eq(product)
        end

        it "redirects to the product" do
          product = create_logged_user_product
          put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
          expect(response).to redirect_to(product)
        end
      end

      describe "with invalid params" do
        it "assigns the product as @product" do
          product = create_logged_user_product
          put :update, {:id => product.to_param, :product => invalid_attributes}, valid_session
          expect(assigns(:product)).to eq(product)
        end

        it "redirects back to the product detail page" do
          product = create_logged_user_product
          put :update, {:id => product.to_param, :product => invalid_attributes}, valid_session
          expect(response).to redirect_to(product_path(product))
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested product" do
        product = create_logged_user_product
        expect {
          delete :destroy, {:id => product.to_param}, valid_session
        }.to change(Product, :count).by(-1)
      end

      it "redirects to the products list" do
        product = create_logged_user_product
        delete :destroy, {:id => product.to_param}, valid_session
        expect(response).to redirect_to(products_url)
      end
    end
  end
end