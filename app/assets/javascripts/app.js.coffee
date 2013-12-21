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

@app = angular.module 'EmployeesCal', ['ngRoute','ngResource','ngSanitize','ngDragDrop', '$strap.directives']


@app.config ["$routeProvider", ($routeProvider) ->
  $routeProvider.otherwise
    templateUrl: '/templates/home.html'
    controller: 'EmployeesCtrl'
]