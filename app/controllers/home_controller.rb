class HomeController < ApplicationController

	before_filter :authenticate_user!, :except => [:index] 

	def index
		if (user_signed_in?)
			redirect_to action: 'panel'
		end
  	end

  	def ztmTicket

  	end

	def panel
		@user = current_user
	end

end
