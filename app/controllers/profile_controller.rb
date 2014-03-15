class ProfileController < ApplicationController

	before_filter :authenticate_user!

	def index 
		@profile = current_user.profile
	end

	def show
		@user = User.find(params[:id])
		@profile = @user.profile
	end
end
