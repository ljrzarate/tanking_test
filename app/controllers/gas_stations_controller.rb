class GasStationsController < ApplicationController

 before_filter :get_gas_station, except: [:new,:create, :index] 

  def get_gas_station
    @gas_station = GasStation.find(params[:id])
  end

  def index
    @gas_stations = GasStation.all
  end

  def new
    @gas_station = GasStation.new
  end

  def create
    @gas_station = GasStation.new(params[:gas_station])
    if @gas_station.save
      redirect_to @gas_station
    else
      render :new
    end
  end

  def show
    @gas_station
  end

  def edit
    @gas_station
  end

  def update
    if @gas_station.update_attributes(params[:gas_station])
       redirect_to @gas_station
     else
      render :edit
    end
  end

  def destroy
    @gas_station = GasStation.find(params[:id])
    @gas_station.destroy
    redirect_to gas_stations_path
  end
end
