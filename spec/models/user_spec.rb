require 'spec_helper'

describe User do
	before do
		@user = FactoryGirl.create(:user)
	end

	subject{@user}

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_me) }

	it { should have_many :cars }
	it { should have_many(:tanking_logs).through :cars}

	it { should be_valid }

	it {should validate_presence_of :name}
	it {should validate_presence_of :email}
	it {should validate_presence_of :password}
	it {should validate_presence_of :password_confirmation}

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end      
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end      
		end
	end
	
	it "When email address ir already taken" do
		#user1 = FactoryGirl.create(:user, email: "example@gmail.com")
		user2 = FactoryGirl.build(:user, email: "example@gmail.com")
		
		user2.email = @user.email.upcase
		user2.should_not be_valid
	end	
	
	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it {should_not be_valid}
	end

	describe "when name it's blank" do
		it "name blank" do
			FactoryGirl.build(:user, name: "").name.should be_empty
		end
	end

	describe "with a password that's too short" do
	  before { @user.password = @user.password_confirmation = "a" * 5 }
	  it { should be_invalid }
	end

end
