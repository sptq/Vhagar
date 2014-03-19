require 'spec_helper'

describe User do
	describe "with admin role" do
		before :all do
			@user = User.new(id: SecureRandom.uuid, email: "admin@example.com", user_role: 'admin')
			@ability = Ability.new(@user)
		end
		subject(:ability) { @ability }

		context "interacts with other user" do
			before :all do
				@other = User.new
			end

			it { should be_able_to :manage, @other }
			it { should be_able_to :promote, @other }
			it { should be_able_to :see_role, @other }
		end

		context "interacts with lecture" do
			before :all do
				@lecture = Lecture.new(id: SecureRandom.uuid, title: "title", description: "description", start_date: Time.now)
			end

			it { should_not be_able_to :attend, @lecture }
			it { should_not be_able_to :resign, @lecture }
			it { should be_able_to :manage, @lecture }
		end
	end
end
