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
  full_month_show = false
  cal = $("#calContent")
  cal.on 'click', '.month-preview', ->
    if (full_month_show) 
      return
    full_month_show = true
    $('.close-month').removeClass('hide')
    month_p = $(@)
    month = month_p.data('month')
    monthName = new Date(0,month,0).getMonthName()
    template = HandlebarsTemplates['full_month']
      month: month
      monthName: monthName
      areas: gon.months_areas[month-1]
    fullmonth = $(".full-month").html template
    fullmonth.css
      'height': month_p.height()
      'width': month_p.width()
      'top': month_p.offset().top
      'left': month_p.offset().left
      'opacity': 0.0
    firstTop = $(".month-preview:first").offset().top
    firstLeft = $(".month-preview:first").offset().left
    fullmonth.removeClass('hide').animate(
      opacity: 1.0
      'height': cal.height()
      'width': cal.width()
      'top': firstTop
      'left': firstLeft
      ,
      900)

  $('.close-month').on 'click', ->
    $(".full-month").fadeOut 600, ->
      $(@).addClass 'hide'
      $(@).css 'display', 'block'
      $('.close-month').addClass 'hide'
      full_month_show = false

  for i in [1..12]
    monthName = new Date(0,i,0).getMonthName()
    template = HandlebarsTemplates['month_item']
      month: i
      monthName: monthName
      areas: gon.months_areas[i-1]
      
    cal.append template

$(document).ready(ready)
$(document).on('page:load', ready)
  