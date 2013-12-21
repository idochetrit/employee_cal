@app.filter 'gradeStr', () ->
  grades = [
      {id: 3, name: 'Super High (1500)'}
      {id: 2, name: 'High (1000)'}
      {id: 1, name: 'Medium (500)'}
      {id: 0, name: 'Low (> 500)'}
    ]
  (input)->
    _.where(grades, {id: +input})[0].name
