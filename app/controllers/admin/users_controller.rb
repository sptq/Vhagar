class Admin::UsersController < ApplicationController
	def index
		if user_signed_in?
			if current_user.is_admin
				@users = User.all
			else
				flash[:alert] = "Page does not exist"
				redirect_to root_path
			end
		end 	
	end
	
	def edit
		redirect_to root_path unless current_user.is_admin 
		
		@user = User.find_by_uuid(params[:id])
	end
end