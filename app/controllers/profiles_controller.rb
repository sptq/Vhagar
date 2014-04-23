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
			redirect_to root_path, notice: 'Stworzyłeś porfil dla swojego konta.'
		else
			render action: :new
		end
	end

	def edit
		params[:id] = current_user.profile.id 
		@profile = current_user.profile
	end

	def update
		if @profile.update(profile_params)
			redirect_to root_path, notice: 'Zaktualizowałeś z powodzeniem porfil dla swojego konta.'
		else
			render action: :edit
		end	
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstName, :lastName, :job, :place, :album, :phone, :id)
    end


end
