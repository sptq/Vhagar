require 'spec_helper'

describe User do
	describe "with user role" do
		before :all do
			@user = User.new(id: SecureRandom.uuid, email: "user@example.com", user_role: 'user')
			@ability = Ability.new(@user)
		end
		subject(:ability) { @ability }

		describe "interacts with other user" do
			before :all do
				@other = User.new
			end

			it { should_not be_able_to :manage, @other }
			it { should_not be_able_to :see_role, @other }
			it { should_not be_able_to :promote,  @other }

			it { should be_able_to :read, Room }
			it { should be_able_to :read, Lecture }
		end

		describe "interacts with lecture" do
			before :all do
				@lecture = Lecture.new(id: SecureRandom.uuid, title: "title", description: "description", start_date: Time.now)
				@lecture.room = Room.new(id: SecureRandom.uuid, title: "title", description: "description", capacity: 10)
			end

			it { should be_able_to :read, @lecture }
			it { should_not be_able_to :manage, @lecture }

			context "does not participates" do
				before :all do
				    @lecture.participants.each do |u|
				    	@lecture.participants.delete u
				    end
				end

				it { @lecture.participants.should_not  include(@user) }
				it { @user.lectures.should_not include(@lecture) }
				it { should be_able_to :attend, @lecture }
				it { should_not be_able_to :resign, @lecture }
			end

			context "already participates" do
				before :all do
				    @lecture.participants.push @user unless @lecture.participants.include?(@user)
				    @user.lectures.push @lecture unless @user.lectures.include?(@lecture)
				end

				it { @lecture.participants.should include(@user) }
				it { @user.lectures.should include(@lecture) }

				it { should_not be_able_to :attend, @lecture }
				it { should be_able_to :resign, @lecture }
			end
		end
	end
end
