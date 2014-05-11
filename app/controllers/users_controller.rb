class UsersController < ApplicationController

	load_and_authorize_resource

	before_filter :authenticate_user!

	def index
		pharse ||= params[:phrase]

		if pharse.present?
			@users = Set.new

			pharse.split(' ').each do |param|
				@users += User.searchByPhrase(param)
			end
		else
			@users = User.all.includes(:profile)
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @user.update_attributes!(user_params)
				format.html { redirect_to users_path, notice: 'Dane logowania zostały zaktualozwane.'}
				format.json { head :no_content}
			else
				format.html { render action: :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@user.isactive ^= true
		@user.save

	    respond_to do |format|
	      format.html { redirect_to users_url }
	      format.json { head :no_content }
	    end
	end

	def adminAddUser
	end

	def adminCreateUser
		@user = User.new()

		@user.email = "#{SecureRandom.uuid}@checkit.org.pl"
		
		#set random password for user
		password = SecureRandom.uuid
		@user.password = password
		@user.password_confirmation = password
		@user.confirmed_at = DateTime.now.to_date
		@user.isactive = true
		@user.acceptTerms = true
		@user.user_role = 'user'

		#add barcode 
		@user.barcode = params[:barcode]

		if @user.save
			@profile = Profile.new()
			@profile.user = @user
			@profile.firstName = params[:firstName]
			@profile.lastName = params[:lastName]
			@profile.place = "#{SecureRandom.uuid}"
			@profile.job = "#{SecureRandom.uuid}"
		

			if @profile.save
				redirect_to users_path, notice: 'Użytkownik został poprawnie dodany'
			else
				redirect_to :back, alert: "#{@profile.errors.inspect}"
			end
		else
			redirect_to :back, alert: "#{@user.errors.inspect}"
		end
	end

	def adminDelete
		user = User.find(params[:user_id])

		if user.profile
			user.profile.destroy
		end
		user.destroy
	end

	def ztmTicket
		if User.where(ztmTicket: true).count <= 400
			if current_user.ztmTicket
				redirect_to panel_ztm_path, alert: 'Posiadasz już darmowy przejazd ZTM.'
			else
				@user = current_user
				@user.ztmTicket = true;
				if @user.save
					redirect_to panel_ztm_path, notice: 'Zobyłeś darmowy przejazd ZTM.'
				else
					redirect_to panel_ztm_path, alert: 'Coś poszło nie tak podczas zapisu, spróbuj jeszcze raz.'
				end
			end
		else
			redirect_to panel_ztm_path, alert: 'Brak darmowych biletów ZTM.'
		end
	end

	def ztmTicketLeaft
		if current_user.ztmTicket
			@user = current_user
			@user.ztmTicket = false

			if @user.save
				redirect_to panel_ztm_path, notice: 'Zrezygnowałeś z darmowego przejazdu ZTM.'
			else
				redirect_to panel_ztm_path, alert: 'Coś poszło nie tak podczas zapisu, spróbuj jeszcze raz.'
			end
		else
			redirect_to panel_ztm_path, alert: 'Nie posiadasz darmowego przejazdu ZTM.'
		end
	end

    ##
    #
	def registrationPanel

	end

	def addBarcode
		barcode = params[:barcode]
		if user = User.where(barcode: barcode).first
			logger.debug user
			redirect_to :back, alert: "#{barcode} jest już w użyciu, proszę wybrać inny"
		else
			user = User.find(params[:user_id])
			user.barcode = params[:barcode]
			user.save
			redirect_to users_path, notice: "Poprawnie przypisano kod #{barcode}"
		end
	end

	def filters
		@users = User.filter(params).includes(:profile)
		render :json => @users
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:user_role, :acceptMarketingTerms, :acceptTerms, :type, :isactive, :confirmed_at, :firstName, :lastName, :phrase, :barcode)
	end
end
