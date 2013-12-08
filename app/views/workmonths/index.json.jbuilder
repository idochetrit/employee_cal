json.array!(@workmonths) do |workmonth|
  json.extract! workmonth, :id
  json.url workmonth_url(workmonth, format: :json)
end
