require 'spec_helper'

describe User do
	describe "abilities" do
		subject(:ability) { Ability.new(user) }

		describe "Admin" do
			let(:user) { User.new(email: "admin@example.com", user_role: 'admin') }
			let(:other) { User.new }

			context "can manage other User" do
				it { should be_able_to(:manage, other) }
			end

			context "can promote other User" do
				it { should be_able_to(:promote, other) }
			end

			context "can see role other User" do
				it { should be_able_to(:see_role, other) }
			end
		end

		describe "Staff" do
			let(:user)    { User.new(email: "staff@example.com", user_role: 'staff') }
			let(:other)   { User.new }
			let(:lecture) { Lecture.new }

			context "cannot promote other user" do
				it { should_not be_able_to(:promote, other) }
			end

			context "cannot create other user" do
				it { should_not be_able_to(:create,  other) }
			end

			context "cannot destroy other user" do
				it { should_not be_able_to(:destroy, other) }
			end

			context "can read other User" do
				it { should be_able_to(:read, other) }
			end

			context "can update, other User" do
				it { should be_able_to(:update, other) }
			end

			context "can see role other User" do
				it { should be_able_to(:see_role, other) }
			end

			context "can manage Lecture" do
				it { should be_able_to(:manage, lecture) }
			end

			context "cannot destroy lecture" do
				it { should_not be_able_to(:destroy, lecture) }
			end
		end

		describe "User" do
			let(:user)   { User.new(email: "user@example.com", user_role: 'user') }
			let(:other)  { User.new }
			let(:lecture) { Lecture.new }

			context "cannot manage other user" do
				it { should_not be_able_to(:manage, other) }
			end

			context "cannot see role other user" do
				it { should_not be_able_to(:see_role, other) }
			end

			context "cannot promote other user" do
				it { should_not be_able_to(:promote,  other) }
			end

			context "can read Lecture" do
				it { should be_able_to(:read, lecture) }
			end

			context "cannot manage Lecture" do
				it { should_not be_able_to(:manage,  lecture) }
			end
		end
	end
end
