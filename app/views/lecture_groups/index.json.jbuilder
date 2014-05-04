json.array!(@lecture_groups) do |lecture_group|
  json.extract! lecture_group, :id, :title, :description
  json.url lecture_group_url(lecture_group, format: :json)
end
