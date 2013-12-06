json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :grade, :areaId
  json.url employee_url(employee, format: :json)
end
