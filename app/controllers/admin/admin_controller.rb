class Admin::AdminController < ApplicationController

	before_filter :authenticate_user!, :is_allowed

	def dashboard		
	end

	def index
		@users = User.where.not(uuid: current_user.uuid)
	end
	
	def edit
		@user = User.where(uuid: params[:id])
	end

	private 

	def is_allowed
		unless current_user.is_admin
			flash[:alert] = "You are not allowed here"
			redirect_to root_path
		end
	end
end