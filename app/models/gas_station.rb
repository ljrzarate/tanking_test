class GasStation < ActiveRecord::Base
  attr_accessible :name

  has_many :tanking_logs

  validates :name, :presence => true
  validates :name, length: { minimum: 6 }
end
