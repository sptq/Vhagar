class ProfileController < ApplicationController

	before_filter :authenticate_user!

	def index 
		@profile = current_user.profile
	end

	def show
		@user = User.find(params[:id])
		@profile = @user.profile
	end

	def create
		@profile = Profile.new(params:profile)
		@profile.user_id = current_user.uuid

		if @profile.save
			
	end

	def edit
	end

	def update
	end



end
