class UsersController < ApplicationController
	def list_users
		if user_signed_in?
			if current_user.is_admin
				@users = User.all
			else
				flash[:alert] = "Page does not exist"
				redirect_to root_path
			end
		end 	
	end
end