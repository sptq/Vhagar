module LectureGroupsHelper
	def availableLectures(group)
		Lecture.where(lecture_group_id: nil) - group.lectures
	end
end
