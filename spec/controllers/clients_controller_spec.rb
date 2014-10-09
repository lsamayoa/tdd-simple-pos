require 'rails_helper'

RSpec.describe ClientsController, :type => :controller do

  let(:valid_attributes) {
    attributes_for(:client)
  }

  let(:invalid_attributes) {
    {
      dododo: "dododo",
      dadada: "dadada"
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClientsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "Authenticated" do

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create(:user)
      sign_in @user
    end

    describe "GET index" do
      it "assigns all logged user clients as @clients" do
        client = create(:client, user: @user)
        get :index, {}, valid_session
        expect(assigns(:clients)).to eq([client])
      end

      it "should not show other user's clients" do
        client = create(:client)
        get :index, {}, valid_session
        expect(assigns(:clients)).to eq([])
      end
    end

    describe "GET show" do
      it "assigns the requested client as @client" do
        client = create(:client, user: @user)
        get :show, {:id => client.to_param}, valid_session
        expect(assigns(:client)).to eq(client)
      end

      it "should not show other user's clients" do
        client = create(:client)
        bypass_rescue
        expect{
          get :show, {:id => client.to_param}, valid_session
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    describe "GET new" do
      it "assigns a new client as @client" do
        get :new, {}, valid_session
        expect(assigns(:client)).to be_a_new(Client)
      end
    end

    describe "GET edit" do
      it "assigns the requested client as @client" do
        client = create(:client, user: @user)
        get :edit, {:id => client.to_param}, valid_session
        expect(assigns(:client)).to eq(client)
      end

      it "should redirect to clients if client do not belong to the logged user" do
        client = create(:client)
        bypass_rescue
        expect{
          get :edit, {:id => client.to_param}, valid_session
        }.to raise_error(Pundit::NotAuthorizedError)
      end

    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Client" do
          expect {
            post :create, {:client => valid_attributes}, valid_session
          }.to change(Client, :count).by(1)
        end

        it "assigns a newly created client as @client" do
          post :create, {:client => valid_attributes}, valid_session
          expect(assigns(:client)).to be_a(Client)
          expect(assigns(:client)).to be_persisted
        end

        it "assigns a the created client as to the logged user" do
          post :create, {:client => valid_attributes}, valid_session
          expect(assigns(:client).user_id).to eq @user.id
        end

        it "redirects to the created client" do
          post :create, {:client => valid_attributes}, valid_session
          expect(response).to redirect_to(Client.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved client as @client" do
          post :create, {:client => invalid_attributes}, valid_session
          expect(assigns(:client)).to be_a_new(Client)
        end

        it "re-renders the 'new' template" do
          post :create, {:client => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          attributes_for(:client, first_name: "Changed")
        }

        it "should not alllow to update other user's client" do
          client = create(:client)
          bypass_rescue
          expect{
            put :update, {:id => client.to_param, :client => new_attributes}, valid_session
          }.to raise_error(Pundit::NotAuthorizedError)
        end

        it "updates the requested client" do
          client = create(:client, user: @user)
          put :update, {:id => client.to_param, :client => new_attributes}, valid_session
          expect(client.reload.first_name).to eq "Changed"
        end

        it "assigns the requested client as @client" do
          client = create(:client, user: @user)
          put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
          expect(assigns(:client)).to eq(client)
        end

        it "redirects to the client" do
          client = create(:client, user: @user)
          put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
          expect(response).to redirect_to(client)
        end
      end

      describe "with invalid params" do
        it "assigns the client as @client" do
          client = create(:client, user: @user)
          put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
          expect(assigns(:client)).to eq(client)
        end

        it "redirects back to the client detail page" do
          client = create(:client, user: @user)
          put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
          expect(response).to redirect_to(client_path(client))
        end
      end
    end

    describe "DELETE destroy" do
      it "should not delete clients if the logged user does not own them" do
        client = create(:client)
        bypass_rescue
        expect {
          delete :destroy, {:id => client.to_param}, valid_session
        }.to raise_error(Pundit::NotAuthorizedError)
      end

      it "destroys the requested client" do
        client = create(:client, user: @user)
        expect {
          delete :destroy, {:id => client.to_param}, valid_session
        }.to change(Client, :count).by(-1)
      end

      it "redirects to the clients list" do
        client = create(:client, user: @user)
        delete :destroy, {:id => client.to_param}, valid_session
        expect(response).to redirect_to(clients_url)
      end
    end
  end

end
