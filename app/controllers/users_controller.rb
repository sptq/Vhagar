class UsersController < ApplicationController

	load_and_authorize_resource

	before_filter :authenticate_user!

	def index
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
		@user.profile.destroy
		@user.destroy
	    respond_to do |format|
	      format.html { redirect_to users_url }
	      format.json { head :no_content }
	    end
	end

	def ztmTicket
		
		if User.where(ztmTicket: true).count <= 400

			if current_user.ztmTicket 
				redirect_to panel_ztm_path, alert: 'Posiadasz już bilet ZTM.'
			else
				@user = current_user
				@user.ztmTicket = true;
				if @user.save
					redirect_to panel_ztm_path, notice: 'Zobyłeś bilet ZTM.'
				else
					redirect_to panel_ztm_path, alert: 'Coś poszło nie tak podczas zapisu, spróbuj jeszcze raz.'
				end
			end
		else 
			redirect_to panel_ztm_path, alert: 'Brak darmowych biletów ZTM.'
		end
	end


	private

    # Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:user_role, :type)
	end
end