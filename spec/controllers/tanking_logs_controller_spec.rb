require 'spec_helper'

describe TankingLogsController do

  before :each do
    @tanking = FactoryGirl.create(:tanking_log)
  end

  context "testing routes" do
    it {should route(:get, "/tanking_logs").to(action: :index)}
    it {should route(:get, "/tanking_logs/new").to(action: :new)}
    it {should route(:post, "/tanking_logs").to(action: :create)}
    it {should route(:get, "/tanking_logs/1").to(action: :show, id: 1)}
    it {should route(:get, "/tanking_logs/1/edit").to(action: :edit, id: 1)}
    it {should route(:put, "/tanking_logs/1").to(action: :update, id: 1)}
    it {should route(:delete, "/tanking_logs/1").to(action: :destroy, id: 1)}
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "have array of tanking_logs" do
      get :index
      assigns(:tanking_logs).should eq([@tanking])
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

    it "create a new tanking_log" do
      get :new
      assigns(:tanking_log).should be_instance_of(TankingLog)
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: @tanking
      response.should be_success
    end

    it "render to the :show view" do
      get :show, id: @tanking
      response.should render_template :show
    end

    it "assigns the requested car to @car" do
      get :show, id: @tanking
      assigns(:tanking_log).should eq(@tanking)
    end

    context "for a fictional car" do
      before do
        get :show, id: @tanking
      end
      it { should assign_to(:tanking_log) }
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
        post :create, tanking_log: FactoryGirl.attributes_for(:tanking_log)
        }.to change(TankingLog, :count).by(1)
    end

    it "redirect to the new tanking_log" do
      post :create, tanking_log: FactoryGirl.attributes_for(:tanking_log)
      response.should redirect_to TankingLog.last
    end

    it "does not save the new tanking_log" do
      expect{
        post :create, tanking_log: FactoryGirl.attributes_for(:tanking_log, cost: 0)
        }.to_not change(TankingLog, :count)
    end

    it "renders the :new when it's invalid" do
        post :create, tanking_log: FactoryGirl.attributes_for(:tanking_log, cost: 0)
        response.should render_template :new
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, id: @tanking
      response.should be_success
    end

    it "render to :edit view" do
      get :edit, id: @tanking
      response.should render_template :edit
    end
  end

  describe "PUT 'update'" do
    context "valid attributes" do
      it "located the requested @tanking_log" do
          put :update, id: @tanking, tanking_log: FactoryGirl.attributes_for(:tanking_log)
          assigns(:tanking_log).should eq(@tanking)
      end

      it "changes @tanking_log's attributes" do
          put :update, id: @tanking, tanking_log: FactoryGirl.attributes_for(:tanking_log, cost: 1000, gallon: 20)
          @tanking.reload
          @tanking.cost.should eq(1000)
          @tanking.gallon.should eq(20)
      end

      it "redirects to the updated tanking" do
          put :update, id: @tanking, tanking_log: FactoryGirl.attributes_for(:tanking_log)
          response.should redirect_to @tanking
      end
    end

    context "invalid attributes" do
      before do
          @static_tanking = FactoryGirl.create(:tanking_log)
      end

        it "locates the requested @tanking_log" do
          put :update, id: @static_tanking, tanking_log: FactoryGirl.attributes_for(:tanking_log, cost: 0)
          assigns(:tanking_log).should eq(@static_tanking)
        end

        it "does not change @tanking_log's attributes" do
          put :update, id: @static_tanking, tanking_log: FactoryGirl.attributes_for(:tanking_log, cost: 2000, gallon: nil)
          @static_tanking.reload
          @static_tanking.cost.should_not eq(2000)
          @static_tanking.gallon.should eq(1.5)
        end

        it "renders the edit method when the car it's invalid" do
          put :update, id: @static_tanking, tanking_log: FactoryGirl.attributes_for(:tanking_log, cost: nil)
          response.should render_template :edit
        end
    end
  end

  describe "DELETE 'destroy'" do

      it "deletes the tanking_log" do
        expect{
          delete :destroy, id: @tanking
          }.to change(TankingLog, :count).by(-1)
      end

      it "redirects to tanking_ogs#index" do
        delete :destroy, id: @tanking
        response.should redirect_to tanking_logs_url
      end
  end

end
