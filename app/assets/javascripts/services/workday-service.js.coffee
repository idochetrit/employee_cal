@app.factory "Workday", ["$resource", ($resource) ->
  $resource "/workdays/:id.json",
    {id: "@id"}
    update: 
      method: "PUT"
]