@app.controller 'FullmonthCtrl',["$scope", "Month", "Workday", ($scope, Month, Workday) ->

  $scope.rerenderCal = ()-> 
    setTimeout(()-> 
        $('#cal-workdays').fullCalendar('render')
      , 20)

  $scope.changeArea = (areaItem)->
    $scope.currentAreaItem = areaItem
    $('#cal-workdays').fullCalendar("refetchEvents")
    return

  prepareFullmonth = (areaItems)->
    $scope.areaItems = areaItems
    $('#cal-workdays').html('').fullCalendar
      defaultView: 'month'
      month: $scope.month-1
      header:
        left: ''
        center: ''
        right: ''
      events: (start, end, callback)-> callback($scope.currentAreaItem.workdays)
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
              $scope.currentAreaItem.workdays.push(wd)
              $('#cal-workdays').fullCalendar("refetchEvents")
    $scope.rerenderCal()
    

  $scope.$on 'fullmonthOpen', (e, currentSelectedMonth)->
    $scope.month = currentSelectedMonth.month
    $scope.monthName = currentSelectedMonth.monthName
    Month.get
      id: $scope.month
      ,(aItem)-> prepareFullmonth(aItem.areaItems)


]