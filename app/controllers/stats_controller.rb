class StatsController < ApplicationController

	def index
		@Users = Users.all
	end
end
