class TankingLogsController < ApplicationController

  before_filter :get_tanking, except: [:new, :create, :index]

  def get_tanking
    @tanking_log = TankingLog.find(params[:id])
  end

  def index
    @tanking_logs = TankingLog.all
  end

  def new
    @tanking_log = TankingLog.new
  end

  def create
    @tanking_log = TankingLog.new(params[:tanking_log])
    if @tanking_log.save
      redirect_to @tanking_log
    else
      render :new
    end
  end

  def show
    @tanking_log
  end

  def edit
    @tanking_log
  end

  def update
    if @tanking_log.update_attributes(params[:tanking_log])
     redirect_to @tanking_log
    else
      render :edit
    end
  end

  def destroy
    @tanking_log.destroy
    redirect_to tanking_logs_path
  end

end
