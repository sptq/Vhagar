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
			render action: :create
		end
	end

	def edit
		if current_user.profile.id == params[:id]
			@profile = current_user.profile
		else
			redirect_to root_path, error: 'To nie jest id twojego profilu!'
		end
	end

	def update
		if @profile.id == current_user.profile.id
			if @profile.update(profile_params)
				redirect_to root_path, notice: 'Zaktualizowałeś z powodzeniem porfil dla swojego konta.'
			else
				render action: :edit
			end
		else
			redirect_to root_path, error: 'To nie jest id twojego profilu!'
		end
	end

	def adminEdit
		if current_user.admin? 
			@profile = Profile.where(id: params[:id])
		else 
			redirect_to root_path, error: 'A ty hakierze jeden!'
		end
	end

	def adminUpdate
		if current_user.admin? 
			if @profile.update(profile_params)
				redirect_to users_path, notice: 'Zaktualizowałeś porfil z powodzeniem.'
			else
				render action: :edit
			end
		else 
			redirect_to root_path, error: 'A ty hakierze jeden!'
		end
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstName, :lastName, :job, :place, :album, :phone, :id)
    end


end
