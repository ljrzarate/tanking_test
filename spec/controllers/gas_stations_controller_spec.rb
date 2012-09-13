require 'spec_helper'

describe GasStationsController do

 before :each do
    @gas_station = FactoryGirl.create(:gas_station)
  end

  context "testing routes" do
    it {should route(:get, "/gas_stations").to(action: :index)}
    it {should route(:get, "/gas_stations/new").to(action: :new)}
    it {should route(:post, "/gas_stations").to(action: :create)}
    it {should route(:get, "/gas_stations/1").to(action: :show, id: 1)}
    it {should route(:get, "/gas_stations/1/edit").to(action: :edit, id: 1)}
    it {should route(:put, "/gas_stations/1").to(action: :update, id: 1)}
    it {should route(:delete, "/gas_stations/1").to(action: :destroy, id: 1)}
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "have array of gas_station" do
      get :index
      assigns(:gas_stations).should eq([@gas_station])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "create a new gas_station" do
      get :new
      assigns(:gas_station).should be_instance_of(GasStation)
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: @gas_station
      response.should be_success
    end

    it "render to the :show view" do
      get :show, id: @gas_station
      response.should render_template :show
    end

    it "assigns the requested gas_station to @gas_station" do
      get :show, id: @gas_station
      assigns(:gas_station).should eq(@gas_station)
    end

    context "for a fictional gas_station" do
      before do
        get :show, id: @gas_station
      end
      it { should assign_to(:gas_station) }
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end

    it "create a new gas_station" do
      expect{
        post :create, gas_station: FactoryGirl.attributes_for(:gas_station)
        }.to change(GasStation, :count).by(1)
    end

    it "redirect to the new gas_station" do
      post :create, gas_station: FactoryGirl.attributes_for(:gas_station)
      response.should redirect_to GasStation.last
    end

    it "does not save the new gas_station" do
      expect{
        post :create, gas_station: FactoryGirl.attributes_for(:gas_station, name: "")
        }.to_not change(GasStation, :count)
    end

    it "renders the :new when it's invalid" do
        post :create, gas_station: FactoryGirl.attributes_for(:gas_station, name: "")
        response.should render_template :new
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, id: @gas_station
      response.should be_success
    end

    it "render to :edit view" do
      get :edit, id: @gas_station
      response.should render_template :edit
    end
  end

  describe "PUT 'update'" do
    context "valid attributes" do
      it "located the requested @gas_station" do
          put :update, id: @gas_station, gas_station: FactoryGirl.attributes_for(:gas_station)
          assigns(:gas_station).should eq(@gas_station)
      end

      it "changes @gas_station attributes" do
        put :update, id: @gas_station, gas_station: FactoryGirl.attributes_for(:gas_station, name: "GASSEL" )
        @gas_station.reload
        @gas_station.name.should eq("GASSEL")
      end

      it "redirects to the updated gas_station" do
          put :update, id: @gas_station, gas_station: FactoryGirl.attributes_for(:gas_station)
          response.should redirect_to @gas_station
      end

      context "invalid attributes" do
      
        it "locates the requested @gas_station" do
          put :update, id: @gas_station, gas_station: FactoryGirl.attributes_for(:gas_station, name: "")
          assigns(:gas_station).should eq(@gas_station)
        end

        it "does not change @gas_station's attributes" do
          put :update, id: @gas_station, gas_station: FactoryGirl.attributes_for(:gas_station, name: "a")
          @gas_station.reload
          @gas_station.name.should eq("Texaco")
        end

        it "renders the edit method when the car it's invalid" do
          put :update, id: @gas_station, gas_station: FactoryGirl.attributes_for(:gas_station, name: nil)
          response.should render_template :edit
        end
    end
    end
  end

  describe "DELETE 'destroy'" do
      it "deletes the gas_station" do
        expect{
          delete :destroy, id: @gas_station
          }.to change(GasStation, :count).by(-1)
      end

      it "redirects to gas_station#index" do
        delete :destroy, id: @gas_station
        response.should redirect_to gas_stations_url
      end
  end

end
