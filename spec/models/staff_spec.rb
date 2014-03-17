require 'spec_helper'

describe User do
	describe "with staff role" do
		before :all do
			@user = User.new(id: SecureRandom.uuid, email: "staff@example.com", user_role: 'staff')
			@ability = Ability.new(@user)
		end
		subject(:ability) { @ability }

		describe "interacts with other user" do
			before :all do
				@other = User.new
				@lecture = Lecture.new
			end

			it { should_not be_able_to :promote, @other }
			it { should_not be_able_to :create,  @other }
			it { should_not be_able_to :destroy, @other }
			it { should be_able_to :read, @other }
			it { should be_able_to :update, @other }
			it { should be_able_to :see_role, @other }
			it { should be_able_to :manage, @lecture }
			it { should_not be_able_to :destroy, @lecture }
		end

		context "interacts with lecture" do
			before :all do
				@lecture = Lecture.new(id: SecureRandom.uuid, title: "title", description: "description", start_date: Time.now)
			end

			it { should_not be_able_to :attend, @lecture }
			it { should_not be_able_to :resign, @lecture }
			it { should be_able_to :manage, @lecture }
			it { should_not be_able_to :destroy, @lecture }
		end
	end
end
