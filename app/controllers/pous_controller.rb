class PousController < ApplicationController

	def index
		@users = User.getOnlyUsers
	end
end
