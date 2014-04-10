class HomeController < ApplicationController

	before_filter :authenticate_user!, :except => [:index]

	def index
		if (user_signed_in?)
			redirect_to action: 'panel'
		end
  	end

  	def ztm
  		@tickets = User.where(ztmTicket: true).count
  		@tickets = 400 - @tickets
  	end

	def panel
		@user = current_user

		if @user.profile and not @user.isactive
			@user.isactive = true
			@user.save
		end
	end

end
