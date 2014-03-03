class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def admin_filter
		unless user_signed_in? && current_user.is_admin
			flash[:alert] = "You are not allowed here"
			redirect_to root_path
		end
	end
end
