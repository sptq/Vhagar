class Content < ActiveRecord::Base

	PLACES = %w[left_header center_header right_header]

	validates :title, presence: true

	before_validation :ensure_uuid

	def ensure_uuid; self.id ||= SecureRandom.uuid end

	def content_params
		params.require(:content).permit(:title, :image_url, :body)
	end
end
