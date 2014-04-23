class UsersController < ApplicationController

	load_and_authorize_resource

	before_filter :authenticate_user!

	def index
		pharse = params[:phrase] || nil

		if pharse != '' && pharse != nil
			@results = []
			@users = []

			@param = params[:phrase].split(' ');
			@param.each do |param|
				@result = User.searchByPhrase(param)

				@result.each do |user|
					@results.push ["#{user.id}", user]
				end
			end	
			
			#filter for only uniq results
			@results = @results.uniq { |s| s.first }

			@results.each do |resultTable|
				@users.push resultTable[1]
			end

			return @users
		else
			@users = User.all
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

	private

    # Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:user_role, :type, :isactive, :confirmed_at, :firstName, :lastName, :phrase, :barcode)
	end
end