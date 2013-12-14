@app.controller 'EmployeesCtrl', ($scope, Workday) ->

  $scope.insertToCal = ()->
    for i in [1..12]
      monthName = new Date(0,i,0).getMonthName()
      template = HandlebarsTemplates['month_item']
        month: i
        monthName: monthName
        areas: gon.months_areas[i-1]
        
      $scope.calContent += template
  $scope.init = ()->
    $scope.show_fullmonth = false
    $scope.show_employees = false
    $scope.months = [1..12]
    $scope.areas = gon.months_areas
    $scope.workdays = gon.months_workdays

  $scope.toggleEmployeesList = ()-> 
    $scope.show_employees = !$scope.show_employees
    $scope.rerenderCal()
  $scope.closeFullmonth = ()-> $scope.show_fullmonth = false 
  $scope.getMonthName = (month)-> (new Date(0,month,0)).getMonthName()
  $scope.getAreaItem = (month)-> $scope.areas[month-1]
  $scope.rerenderCal = ()-> 
    setTimeout(()-> 
        $('#cal-workdays').fullCalendar('render')
      , 20)

  $scope.openFullMonth = (month)->
    if $scope.show_fullmonth then return
    monthName = new Date(0,month,0).getMonthName()
    $scope.currentAreasItem = 
      month: month
      monthName: monthName
      areas: $scope.getAreaItem(month)
    $scope.show_fullmonth = true

    $('#cal-workdays').html('').fullCalendar
      defaultView: 'month'
      month: month-1
      header:
        left: ''
        center: 'title'
        right: ''
      events: $scope.workdays[month-1].workdays
      droppable: true
      drop: (date, allDay)->
      
        originalEventObject = $(this).data('emp-obj');
        copiedEventObject = $.extend({}, originalEventObject);
        copiedEventObject.start = date
        copiedEventObject.allDay = allDay
        

        existEvents = $('#cal-workdays').fullCalendar 'clientEvents', (e)->
          if date.getDate() == e.start.getDate() and e.employee_id == originalEventObject.employee_id
            return true
          
        if existEvents.length == 0
          $('#cal-workdays').fullCalendar('renderEvent', copiedEventObject, true);
        
          serverDate = new Date(date.getYear()+1900,date.getMonth(),date.getDate()+1)
          Workday.save
            workday:
              id: originalEventObject.id
              employee_id: originalEventObject.employee_id
              start: serverDate
              end: serverDate
    
    $scope.rerenderCal()
    
