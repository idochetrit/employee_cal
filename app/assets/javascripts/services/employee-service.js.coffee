
@app.factory "Employee", ($resource) ->
  $resource "/employees/:id.json",
    {id: "@id"}
    update: 
      method: "PUT"    
