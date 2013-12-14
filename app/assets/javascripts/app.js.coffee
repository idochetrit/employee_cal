# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
Date.prototype.monthNames = [
    "January", "February", "March",
    "April", "May", "June",
    "July", "August", "September",
    "October", "November", "December"
]

Date.prototype.getMonthName = ->
  return this.monthNames[this.getMonth()];

# $httpProvider.defaults.headers.common["Content-Type"] = 'application/json'

@app = angular.module 'EmployeesCal', ['ngResource','ngSanitize','ngDragDrop']
@app.factory "Workday", ($resource) ->
  $resource "/workdays/:id.json",
    {id: "@id"}
    update: 
      method: "PUT"

@app.factory "Employee", ($resource) ->
  $resource "/employees/:id",
    {id: "@id"}
    update: 
      method: "PUT"    

