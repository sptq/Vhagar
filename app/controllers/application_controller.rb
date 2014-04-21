class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :get_header_content
	
	before_action :configure_permitted_parameters, if: :devise_controller?

	rescue_from CanCan::Unauthorized do |exception|
		redirect_to root_url, alert: exception.message
	end unless :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
	  redirect_to root_url, alert: exception.message
	end

	def content_for_place(place)
		Content.where(place: place.to_s).first
	end

	def get_header_content
		left = content_for_place :left_header
		center = content_for_place :center_header
		right = content_for_place :right_header

		@header_display_contet = {
			left_header: left,
			center_header: center,
			right_header: right
		}
	end

	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :acceptMarketingTerms, :acceptTerms, :email, :password, :password_confirmation) }
	end
end
