
@app.factory "Month", ["$resource", ($resource) ->
  $resource "/months/:id.json",
    {id: "@id"}
    update: 
      method: "PUT" 
]
