@app.controller 'EmployeesCtrl', ["$scope", "$http", "Area", "Employee", "Workmonth",
  ($scope, $http, Area, Employee, Workmonth) ->
    $scope.newEmployee = {}
    $scope.newEmployeeWM = {}
    $scope.currentWorkdays = []

    $scope.employees = Employee.query()
    $scope.areas = Area.query()
    
    $scope.months = [1..12]
    $scope.show_employees = true
    $scope.show_fullmonth = false

    Sortable.init()
    
    
    updateCalendar = ()->
      $http.get('/months/index.json').success (json)-> 
        $scope.areas_months = json
    updateEmpList = ()->
      $scope.employees = Employee.query()

    saveWM = (wmItem, emp_id)->
      start = Math.min(wmItem.from, wmItem.to)
      end = Math.max(wmItem.from, wmItem.to)
      for m in [start..end]
        Workmonth.save
          workmonth: 
            month: m
            employee_id: emp_id

    $scope.deleteEmployee = (employee) -> 
      employee.$delete ->  
        updateEmpList()
        updateCalendar()

    $scope.editEmployee = (employee) ->
      $scope.newEmployeeMethod = 'update'
      $scope.newEmployee = employee

    $scope.saveNewEmployee = () ->
      $scope.newEmployeeMethod = 'update' if $scope.newEmployeeMethod == 'update'
      
      Employee[$scope.newEmployeeMethod] $scope.newEmployee, (emp)-> 
        saveWM($scope.newEmployeeWM, emp.id) if $scope.newEmployeeMethod == 'save'
        updateEmpList()
        updateCalendar()
        $scope.newEmployeeWM = {}

      $scope.newEmployee = {}
      #CLOSE modal
      $("#employeeModal").modal('hide')
      return

    #tmp grade obj
    $scope.grades = [
      {id: 3, name: 'Super High (1500)'}
      {id: 2, name: 'High (1000)'}
      {id: 1, name: 'Medium (500)'}
      {id: 0, name: 'Low (> 500)'}
    ]

    updateCalendar()
  #***********************#

    $scope.rerenderCal = ()-> 
      setTimeout(()-> 
          $('#cal-workdays').fullCalendar('render')
        , 20)
    $scope.toggleEmployeesList = ()-> 
      $scope.show_employees = !$scope.show_employees
      $scope.rerenderCal()

    $scope.closeFullmonth = ()-> $scope.show_fullmonth = false 
    $scope.getMonthName = (month)-> (new Date(0,month,0)).getMonthName()
    $scope.getAreaItem = (month)-> $scope.areas_months[month-1]


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
        areas_months: $scope.getAreaItem(month)
      $scope.show_fullmonth = true
      $scope.$broadcast('fullmonthOpen',$scope.currentAreasItem)
]