class StatsController < ApplicationController

	load_and_authorize_resource

	def index
		@users = User.all.count
		@unapprovedUsers = User.where(confirmed_at: nil).count
		@approvedUsers = @users - @unapprovedUsers;
		@usersWithProfiles = Profile.all.count
		@usersWithOutProfiles = @users - @usersWithProfiles
		@usersWithTickets = User.where(ztmTicket: true).count

		@users = {
			:all => @users,
			:approvedUsers => @approvedUsers,
			:unapproved => @unapprovedUsers,
			:withProfile => @usersWithProfiles,
			:withoutProfile => @usersWithOutProfiles,
			:withTickets => @usersWithTickets
		}
	end
end
