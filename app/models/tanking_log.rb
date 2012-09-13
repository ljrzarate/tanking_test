class TankingLog < ActiveRecord::Base

  belongs_to :gas_station
  belongs_to :car

  attr_accessible :car_id, :cost, :date, :gallon, :gas_station_id, :km

  validates_presence_of :cost , :date , :gallon , :km, :car_id, :gas_station_id
  validates_numericality_of :cost , :gallon
  validates_numericality_of :km, only_integer: true

  validates :cost, :gallon, numericality: {greater_than: 0}
  
end
