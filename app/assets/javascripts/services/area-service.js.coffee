
@app.factory "Area", ($resource) ->
  $resource "/areas/:id.json",
    {id: "@id"}
    update: 
      method: "PUT"    
