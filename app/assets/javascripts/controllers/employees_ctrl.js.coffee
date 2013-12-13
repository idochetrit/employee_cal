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

  $scope.toggleEmployeesList = ()-> $scope.show_employees = !$scope.show_employees
  $scope.closeFullmonth = ()-> $scope.show_fullmonth = false  
  $scope.getAreaItem = (month)-> $scope.areas[month-1]
  $scope.getMonthName = (month)-> (new Date(0,month,0)).getMonthName()

  $scope.openFullMonth = (month)->
    if $scope.show_fullmonth then return
    monthName = new Date(0,month,0).getMonthName()
    $scope.currentAreasItem = 
      month: month
      monthName: monthName
      areas: $scope.getAreaItem month
    $scope.show_fullmonth = true

    $('#cal-workdays').html('').fullCalendar
      defaultView: 'month'
      month: month-1
      header:
        left: ''
        center: 'title'
        right: ''
      editable: true,
      droppable: true, 
      drop: (date, allDay)->
      
        originalEventObject = $(this).data('emp-obj');
        copiedEventObject = $.extend({}, originalEventObject);
        
        copiedEventObject.start = date
        copiedEventObject.allDay = allDay
        $('#cal-workdays').fullCalendar('renderEvent', copiedEventObject, true);
        
        Workday.save
          workday:
            employee_id: originalEventObject.employee_id
            start: date
            end: date
        
    setTimeout(()-> 
        $('#cal-workdays').fullCalendar('render')
      , 20)

