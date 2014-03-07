class Admin::AdminController < ApplicationController

	before_filter :authenticate_user!

	def dashboard
	end

	def index
		@users = User.where.not(uuid: current_user.uuid)
	end

	def edit
		@user = User.where(uuid: params[:id])
	end
end