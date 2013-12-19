@app.controller 'FullmonthCtrl',["$scope", "Workday", ($scope, Workday) ->
  $scope.rerenderCal = ()-> 
    setTimeout(()-> 
        $('#cal-workdays').fullCalendar('render')
      , 20)
  $scope.$on 'fullmonthOpen', ()->
    $('#cal-workdays').html('').fullCalendar
      defaultView: 'month'
      month: $scope.$parent.currentAreasItem.month-1
      header:
        left: ''
        center: ''
        right: ''
      events: (start, end, callback)-> callback($scope.$parent.currentWorkdays)
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
]