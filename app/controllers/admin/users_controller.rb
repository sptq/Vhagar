class Admin::UsersController < ApplicationController

	before_filter :authenticate_user!, :is_allowed

	def index
		@users = User.all
	end

	def edit
		@user = User.where(uuid: params[:id]).first
	end

	private

	def is_allowed
		unless current_user.is_admin
			flash[:alert] = "You are not allowed here"
			redirect_to root_path
		end
	end
end