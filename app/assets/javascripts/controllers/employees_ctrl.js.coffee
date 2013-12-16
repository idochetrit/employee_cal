@app.controller 'EmployeesCtrl', ($scope, Workday) ->

  
  $scope.init = ()->
    $scope.show_fullmonth = false
    $scope.show_employees = false
    $scope.months = [1..12]
    $scope.currentWorkdays = []
    $scope.areas = gon.months_areas

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

  $scope.changeArea = (areaItem)->
    $scope.currentWorkdays = areaItem.workdays
    $('#cal-workdays').fullCalendar("refetchEvents")
    return

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
        center: ''
        right: ''
      events: (start, end, callback)-> callback($scope.currentWorkdays)
      droppable: true
      eventClick: (calEvent, jsEvent, view)->
        cal = $('#cal-workdays').fullCalendar('removeEvents', calEvent._id)
        Workday.delete({id: calEvent.wd_id})
        cal.fullCalendar("rerenderEvents")
        alert("Workday removed!")
      drop: (date, allDay)->
      
        originalEventObject = $(this).data('emp-obj');
        copiedEventObject = $.extend({}, originalEventObject);

        copiedEventObject.start = date
        copiedEventObject.allDay = allDay
        

        existEvents = $('#cal-workdays').fullCalendar 'clientEvents', (e)->
          if date.getDate() == e.start.getDate() and e.employee_id == originalEventObject.employee_id
            return true
          
        if existEvents.length == 0
          # $('#cal-workdays').fullCalendar('renderEvent', copiedEventObject, true);
        
          serverDate = new Date(date.getYear()+1900,date.getMonth(),date.getDate()+1)
          Workday.save
            workday:
              id: originalEventObject.wd_id
              employee_id: originalEventObject.employee_id
              start: serverDate
              end: serverDate
            , (wd)-> 
              $scope.currentWorkdays.push(wd)
              $('#cal-workdays').fullCalendar("refetchEvents")
    
    $scope.rerenderCal()
    

