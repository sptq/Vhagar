class UsersController < ApplicationController
	def show
		if user_signed_in?
			if current_user.user_role.to_sym == :user
				# TODO : wyświetlić komunikat
				redirect_to root_path
			else
				@users = User.all
			end
		end 	
	end
end