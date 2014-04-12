module ContentsHelper
	def available_places(content)
		used = Content.uniq.pluck(:place)
		used.delete content.place unless content.place.nil?
		Content::PLACES - used
	end
end
