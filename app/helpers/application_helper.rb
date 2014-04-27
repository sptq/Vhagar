module ApplicationHelper
	def title(page_title)
		content_for(:title) { page_title }
	end

	def avatar_url(user)
		if defined? user.avatar_url and user.avatar_url.present?
			user.avatar_url
		else
			gravatar_url(user)
		end
	end

	def gravatar_url(user)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}"
	end
	
	def extract_participation(lecture, user)
      common = user.participations & lecture.participations
      common.first
	end
end
