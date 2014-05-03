class PousController < ApplicationController

	def index
		@users = User.filter(params)
	end

end
