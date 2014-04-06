class StatsController < ApplicationController

	load_and_authorize_resource

	def index
		@Users = User.all
	end
end
