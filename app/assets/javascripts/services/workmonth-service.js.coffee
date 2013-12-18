@app.factory "Workmonth", ($resource) ->
  $resource "/workmonths/:id.json",
    {id: "@id"}
    update: 
      method: "PUT"
