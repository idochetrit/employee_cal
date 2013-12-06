# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
Date.prototype.monthNames = [
    "January", "February", "March",
    "April", "May", "June",
    "July", "August", "September",
    "October", "November", "December"
]

Date.prototype.getMonthName = ->
  return this.monthNames[this.getMonth()];
ready = ->
  cal = $("#calContent")
  for i in [1..12]
    monthName = new Date(0,i,0).getMonthName()
    template = HandlebarsTemplates['month_item']
      month: i
      monthName: monthName
      areas: gon.months_areas[i-1]
    cal.append template

$(document).ready(ready)
$(document).on('page:load', ready)
  
  
