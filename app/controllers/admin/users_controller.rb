class Admin::UsersController < ApplicationController

	before_filter :authenticate_user!, :admin_filter
	before_action :set_user, only: [:edit, :update]

	def index
		@users = User.all
	end

	def edit
	end

	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to admin_users_path, notice: 'User was successfully updated. '}
				format.json { head :no_content}
			else
				format.html { render action: :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def is_allowed
		unless current_user.is_admin
			flash[:alert] = "You are not allowed here"
			redirect_to root_path
		end
	end

    # Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.where(uuid: params[:id]).first
	end

    # Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:user_role, :type)
	end
end