class StatsController < ApplicationController

	load_and_authorize_resource

	def index
		allUsers = User.all.count
		unapprovedUsers = User.where(confirmed_at: nil).count
		approvedUsers = allUsers = unapprovedUsers;
		usersWithTickets = User.where(ztmTicket: true).count

		@users = {
			:all => allUsers,
			:approvedUsers => approvedUsers,
			:unapproved => unapprovedUsers,
			:withTickets => usersWithTickets
		}
	end
end
