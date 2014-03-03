json.array!(@lectures) do |lecture|
  json.extract! lecture, :id, :title, :description, :start_date
  json.url admin_lecture_url(lecture, format: :json)
end
