class CarsController < ApplicationController

  before_filter :get_car, except: [:new,:create, :index] 

    def get_car
      @car = Car.find(params[:id])
    end

    def index
      @cars = Car.all
    end

    def new
      @car = Car.new
    end

    def create
      @car = Car.new(params[:car])
      if @car.save
        redirect_to @car
      else
        render :new
      end
    end

    def show
      @car
    end

    def edit
      @car
    end

    def update
      if @car.update_attributes(params[:car])
       redirect_to @car
     else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to cars_path
  end
end
