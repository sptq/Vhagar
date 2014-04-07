class ProfilesController < ApplicationController

	load_and_authorize_resource

	def index
		@profile = current_user.profile
	end

	def show
		@profile = Profile.find(params[:id])
	end

	def new
		if current_user.profile
			redirect_to profiles_path
		else
			@profile = Profile.new
		end
	end

	def create
		@profile.user_id = current_user.id

		if @profile.save
			current_user.user_role = 'user'
			redirect_to root_path, notice: 'User was successfully updated.'
		else
			render action: :edit
		end
	end

	def edit
	end

	def update
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstName, :lastName, :job, :place, :phone, :id)
    end


end
