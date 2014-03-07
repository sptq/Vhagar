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
				format.html { redirect_to users_path, notice: 'User was successfully updated. '}
				format.json { head :no_content}
			else
				format.html { render action: :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:user_role, :type)
	end
end