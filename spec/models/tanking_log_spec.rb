require 'spec_helper'

describe TankingLog do

	before do

		@tanking_log = FactoryGirl.create(:tanking_log)

		@tanking_log_temp = FactoryGirl.build(:tanking_log)

	end

	subject{@tanking_log}

	it { should respond_to(:cost)}
	it { should respond_to(:km) }
	it { should respond_to(:date) }
	it { should respond_to(:gallon) }
	it { should respond_to(:gas_station_id) }
	it { should respond_to(:car_id)}
	it { should belong_to :car}
	it { should belong_to :gas_station}

	it { should be_valid }

	it { should validate_presence_of(:cost) }
	it { should validate_presence_of :km}
	it { should validate_presence_of :date}
	it { should validate_presence_of :gallon}
	it { should validate_presence_of :gas_station_id}
	it { should validate_presence_of :car_id}

	context "when some proprerty it's blank" do
		it "cost blank" do
			FactoryGirl.build(:tanking_log, cost: nil).should_not be_valid
		end

		it "km blank" do
			FactoryGirl.build(:tanking_log, km: nil).should_not be_valid
		end

		it "date blank" do
			FactoryGirl.build(:tanking_log, date: nil).should_not be_valid
		end

		it "gallon blank" do
			FactoryGirl.build(:tanking_log, gallon: nil).should_not be_valid
		end

		it "gas_station_id blank" do
			FactoryGirl.build(:tanking_log, gas_station_id: nil).should_not be_valid
		end

		it "car_id blank" do
			FactoryGirl.build(:tanking_log, car_id: nil).should_not be_valid
		end
	end

	context "Creating Valid TankingLogs arguments" do
		it 'Cost must be float' do
			@tanking_log_temp.cost.should be_a_kind_of Float
		end

		it 'Gallon must be float' do
			@tanking_log_temp.gallon.should be_a_kind_of Float
		end

		it 'Date must be Time' do
			@tanking_log_temp.date.should be_a_kind_of Time
		end
		
		it 'gas_station_id must be Fixnum' do
			@tanking_log_temp.gas_station_id.should be_a_kind_of Fixnum
		end

		it 'car_id must be Fixnum' do
			@tanking_log_temp.car_id.should be_a_kind_of Fixnum
		end
	end

	context "Creating invalids TankingLogs arguments" do
		it 'Cost with invalid kind of value' do
			FactoryGirl.build(:tanking_log, cost: "123,3").should_not be_a_kind_of Float
		end

		it 'Gallon with invalid kind of value' do
			FactoryGirl.build(:tanking_log, gallon: "11.4").should_not be_a_kind_of Float
		end

		it 'Date with invalid kind of value' do
			FactoryGirl.build(:tanking_log, date: "2012-05-03").should_not be_a_kind_of Time
		end

		it 'gas_station_id must be Fixnum' do
			FactoryGirl.build(:tanking_log, gas_station_id: "id").should_not be_a_kind_of Fixnum
		end

		it 'car_id must be Fixnum' do
			FactoryGirl.build(:tanking_log, car_id: "test").should_not be_a_kind_of Fixnum
		end
	end

end
