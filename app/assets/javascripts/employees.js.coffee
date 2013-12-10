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

class app
    
  constructor: ->
    @fullmonth =  $(".full-month")
    @cal =  $("#calContent")
    @full_month_show =  false
    Handlebars.registerHelper 'gradeStr', (num)->
      switch num
        when 0 then 'Low'
        when 1 then 'Medium'
        when 2 then 'High'
        
    @handle_events()
  
  handle_events: ->
    # click on month
    cal = @cal
    @cal.on 'click', '.month-preview', (e)=>
      if (@full_month_show) 
        return
      @full_month_show = true
      month_p = $(e.target).closest(".month-preview")
      month = month_p.data('month')
      monthName = new Date(0,month,0).getMonthName()

      template = HandlebarsTemplates['full_month']
        month: month
        monthName: monthName
        areas: gon.months_areas[month-1]

      @fullmonth = $(".full-month").html template

      @fullmonth.find('.close-month').removeClass 'hide'
      @currentTop = month_p.offset().top
      @currentLeft = month_p.offset().left
      @fullmonth.css
        'height': month_p.height()
        'width': month_p.width()
        'top': @currentTop
        'left': @currentLeft
        'opacity': 0.8
      firstTop = $(".month-preview:first").offset().top
      firstLeft = $(".month-preview:first").offset().left
      @fullmonth.removeClass('hide').find('.area-tab:first, .area-content:first').addClass 'active'
      @toggle_fullmonth firstLeft, firstTop, @cal.width(), @cal.height(), 250

    # click on close
    @fullmonth.on 'click', '.close-month', =>
      @toggle_fullmonth @currentLeft+50, @currentTop+50, 100, 100, 200, =>
        @fullmonth.addClass 'hide'
        $('.close-month').addClass 'hide'
        @full_month_show = false

    $('.toggle-employees').on 'click', (e)=> 
      @cal.toggleClass('col-md-8').toggleClass('col-md-12')
      $('.employees-list').toggleClass 'hide'
      e.preventDefault()

  toggle_fullmonth: (l, t, w, h, speed, callback= null)->
    @fullmonth.animate
      opacity: 1.0
      'height': h
      'width': w
      'top': t
      'left': l
      ,
      speed, 'swing', callback
  
  init_calendar: ->
    for i in [1..12]
      monthName = new Date(0,i,0).getMonthName()
      template = HandlebarsTemplates['month_item']
        month: i
        monthName: monthName
        areas: gon.months_areas[i-1]
        
      @cal.append template

ready = ->
  a = new app()
  a.init_calendar()


$(document).ready(ready)
$(document).on('page:load', ready)
