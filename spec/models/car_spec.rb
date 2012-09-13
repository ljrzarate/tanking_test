require 'spec_helper'

describe Car do

        before :each do
           @car = FactoryGirl.create(:car)
       end

       subject{@car}

       it { should respond_to(:brand) }
       it { should respond_to(:model) }
       it { should respond_to(:year) }
       it { should respond_to(:color) }
       it { should respond_to(:tanking_logs) }
       it {should respond_to(:user_id)}

       it { should be_valid }

       it {should belong_to(:user)}
       it {should have_many(:tanking_logs)}

       it {should validate_presence_of :brand}
       it {should validate_presence_of :model}
       it {should validate_presence_of :year}
       it {should validate_presence_of :color}

       context "create a car" do
        context "create a invalid car" do
            it "(without model) " do
                FactoryGirl.build(:car, model: nil).should_not be_valid
            end

            it "(without brand) " do
                FactoryGirl.build(:car, brand: nil).should_not be_valid
            end

            it "(without year) " do
                FactoryGirl.build(:car, year: nil).should_not be_valid
            end

            it "(without color) " do
                FactoryGirl.build(:car, color: nil).should_not be_valid
            end
        end 

    end

    context "validates of :year" do
        it "year must be integer" do
            FactoryGirl.build(:car, year: 123).year.should be_a_kind_of Fixnum
        end

        it "year must be greather than 1980 and less than current year + 1" do
            next_year = Time.now.year+1
            car_year =FactoryGirl.build(:car_current_year).year
            car_year.should >= 1980
            car_year.should <= next_year
        end
    end

end
