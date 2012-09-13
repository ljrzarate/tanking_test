require 'spec_helper'

describe GasStation do

	before do
		@gas = FactoryGirl.create(:gas_station)
	end

	subject {@gas}

	it { should respond_to(:name)}
	it { should respond_to(:tanking_logs)}

	it {should validate_presence_of :name}

	it { should be_valid}
	it { should have_many :tanking_logs}

	it "a name must be a String" do
		FactoryGirl.create(:gas_station).name.should be_kind_of String
	end

	it "width a name that's too short" do
		FactoryGirl.build(:gas_station, name: "a"*5).should_not be_valid
	end
end
