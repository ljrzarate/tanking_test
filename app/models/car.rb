class Car < ActiveRecord::Base
	
  belongs_to :user
  has_many :tanking_logs, dependent: :destroy

  attr_accessible :brand, :color, :model, :user_id, :year

 validates :brand, :color, :model, :year, :presence => true

end
