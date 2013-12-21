
@app.factory "Vacation", ["$resource",  ($resource) ->
  $resource "/vacations/:id.json",
    {id: "@id"}
    update: 
      method: "PUT"    
]