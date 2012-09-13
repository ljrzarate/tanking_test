require 'spec_helper'

describe CarsController do

  before do
    @car = FactoryGirl.create(:car)

  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "have array of cars" do
      get :index
      assigns(:cars).should eq([@car])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end

    it "route to index" do
      should route(:get, "/cars").to(action: :index)
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "create a new car" do
      get :new
      assigns(:car).should be_instance_of(Car)
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end

    it "route to :new" do
      should route(:get, "cars/new").to(action: :new)
    end 

  end

  describe "GET 'show'" do

    it "returns http success" do
      get :show, id: @car
      response.should be_success
    end

    it "render to the :show view" do
      get :show, id: @car
      response.should render_template :show
    end

    it "assigns the requested car to @car" do
      get :show, id: @car
      assigns(:car).should eq(@car)
    end

    it "routes to show" do
     should route(:get, "cars/1").to(action: :show, id: 1)
   end

   context "for a fictional car" do
    before do
      get :show, id: @car
    end

    it { should assign_to(:car) }
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

  it "create a new car" do
    expect{
      post :create, car: FactoryGirl.attributes_for(:car)
      }.to change(Car, :count).by(1)
    end

    it "redirect to the new car" do
      post :create, car: FactoryGirl.attributes_for(:car)
      response.should redirect_to Car.last

    end

    it "does not save the new contact" do
      expect{
        post :create, car: FactoryGirl.attributes_for(:car, color: "")
        }.to_not change(Car,:count)
      end

      it "renders the :new when it's invalid" do
        post :create, car: FactoryGirl.attributes_for(:car, color: "")
        response.should render_template :new
      end

      it "routes to :create" do
        should route(:post, "/cars").to(action: :create)
      end

    end

    describe "GET 'edit'" do
      it "returns http success" do
        get :edit, id: @car
        response.should be_success
      end

      it "render to :edit view" do
        get :edit, id: @car
        response.should render_template :edit
      end

      it "routes to :edit" do
        should route(:get, "cars/1/edit").to(action: :edit, id: 1)
      end
    end

    describe "PUT 'update'" do
      context "valid attributes" do

        it "located the requested @car" do
          put :update, id: @car, car: FactoryGirl.attributes_for(:car)
          assigns(:car).should eq(@car)      
        end

        it "changes @car's attributes" do
          put :update, id: @car, car: FactoryGirl.attributes_for(:car, brand: "BMW", model: "2012")
          @car.reload
          @car.brand.should eq("BMW")
          @car.model.should eq("2012")
        end             

        it "redirects to the updated car" do
          put :update, id: @car, car: FactoryGirl.attributes_for(:car)
          response.should redirect_to @car
        end

        it "routes to update" do
          should route(:put, "/cars/1").to(action: :update, id: 1)
        end
      end

      context "invalid attributes" do
        before do
          @static_car = FactoryGirl.create(:static_car)
        end

        it "locates the requested @car" do
          put :update, id: @car, car: FactoryGirl.attributes_for(:car, model: nil)
          assigns(:car).should eq(@car)
        end

        it "does not change @car's attributes" do
          put :update, id: @static_car, car: FactoryGirl.attributes_for(:static_car, brand: "Lamborgini", color: nil)
          @static_car.reload
          @static_car.brand.should_not eq("Lamborgini")
          @static_car.model.should eq("ASD")
        end

        it "renders the edit method when the car it's invalid" do
          put :update, id: @car, car: FactoryGirl.attributes_for(:car, model: nil)
          response.should render_template :edit
        end
      end
    end

    describe "DELETE 'destroy'" do

      it "deletes the car" do
        expect{
          delete :destroy, id: @car
          }.to change(Car, :count).by(-1)
        end

        it "redirects to cars#index" do
          delete :destroy, id: @car
          response.should redirect_to cars_url
        end

        it "routes to :delete" do
          should route(:delete, "/cars/1").to(action: :destroy, id: 1)
        end
      end

    end
