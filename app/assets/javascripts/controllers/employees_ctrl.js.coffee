@app.controller 'EmployeesCtrl', ["$scope", "$http", "Area", "Employee", "Workmonth","Vacation", "Month"
  ($scope, $http, Area, Employee, Workmonth, Vacation, Month) ->
    $scope.newEmployee = {}
    $scope.newEmployeeWM = {from: 1, to: 12}

    $scope.monthMin = 1
    $scope.monthMax = 12
    $scope.newEmployeeWM_min = $scope.monthMin
    $scope.newEmployeeWM_max = $scope.monthMax
    


    $scope.newVacation = {}
    $scope.current_employee_id

    $scope.newEmployeeMethod = 'save'

    $scope.areas_months = []

    $scope.employees = Employee.query()
    $scope.areas = Area.query()
    
    $scope.months = [1..12]
    $scope.show_employees = true
    $scope.show_fullmonth = false


    $http.defaults.headers.post["Content-Type"] = "application/json";
    angular.element(document).ready ()->
      $(".employees-list table").stupidtable()
    

    $scope.clearForm = ()->
      $scope.newEmployee = {}
      $scope.newEmployeeWM = {}
      $scope.newEmployeeMethod = 'save'
      $scope.$apply() if not $scope.$$phase
      $("#employeeModal").modal('hide')
      console.log 'form cleared...'

    updateCalendar = ()->
      Month.query (areaItems_months)->
        $scope.areas_months = areaItems_months

    updateEmpList = ()->
      $scope.employees = Employee.query()

    saveWM = (min, max, emp_id)->
      Workmonth.save
        workmonth:
          month_start: min
          month_end: max
          employee_id: emp_id
        ,
        (wm)-> 
          updateCalendar()
          $scope.$apply() if not $scope.$$phase
      

    $scope.deleteEmployee = (employee, index) -> 
      msg = "Are you sure?"
      if confirm(msg)
        employee.$delete ->
          $scope.employees.splice(index, 1)
          updateCalendar()

    $scope.editEmployee = (employee) ->
      $scope.newEmployeeMethod = 'update'
      $scope.newEmployee = angular.copy(employee)
      $scope.newEmployeeWM_min = $scope.newEmployee.min_month
      $scope.newEmployeeWM_max = $scope.newEmployee.max_month

    $scope.saveNewEmployee = (min, max) ->
      $scope.newEmployeeMethod = 'update' if $scope.newEmployeeMethod == 'update'
      
      Employee[$scope.newEmployeeMethod](id: $scope.newEmployee.id, employee: $scope.newEmployee)
      .$promise.then (employee)->
        if $scope.newEmployeeMethod == 'save'
          $scope.employees.push employee
        else
          e = _.where($scope.employees, {id: employee.id})[0]
          index = $scope.employees.indexOf(e)
          $scope.employees[index] = employee

        saveWM(min, max,employee.id)
        $scope.clearForm()
        
      #CLOSE modal
      $("#employeeModal").modal('hide')
      return
      
    $scope.setTempEmpId = (id) ->
      $scope.current_employee_id = id

    addVacationModel = (wm_start, wm_end, m)->
      Vacation.save(
        month: m
        employee_id: $scope.current_employee_id 
        start_vacation: wm_start
        end_vacation: wm_end
      ).$promise.then -> updateCalendar()

    $scope.addNewVacation = ()->
      wm_start = $scope.newVacation.start.getMonth() + 1
      wm_end = $scope.newVacation.end.getMonth() + 1
      if wm_start == wm_end
        addVacationModel($scope.newVacation.start, $scope.newVacation.end, wm_start)
      else
        addVacationModel($scope.newVacation.start, $scope.newVacation.end, wm_start)
        addVacationModel($scope.newVacation.start, $scope.newVacation.end, wm_end)
      $scope.newVacation = {}

      $("#vacationModal").modal('hide')
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
    $scope.getAreaItem = (month)-> 
      $scope.areas_months[month-1].areaItems if $scope.areas_months[month-1]

    $scope.openFullMonth = (month)->
      if $scope.show_fullmonth then return
      monthName = new Date(0,month,0).getMonthName()
      $scope.currentMonthSelected = 
        month: month
        monthName: monthName
      $scope.show_fullmonth = true
      $scope.$broadcast('fullmonthOpen',$scope.currentMonthSelected)
]