@app.controller 'EmployeesCtrl', ["$scope", "$http", "Area", "Employee", "Workmonth","Vacation"
  ($scope, $http, Area, Employee, Workmonth, Vacation) ->
    $scope.newEmployee = {}
    $scope.newEmployeeWM = {}
    $scope.newVacation = {}
    $scope.current_employee_id

    $scope.currentWorkdays = []
    $scope.areas_months = []

    $scope.employees = Employee.query()
    $scope.areas = Area.query()
    
    $scope.months = [1..12]
    $scope.show_employees = true
    $scope.show_fullmonth = false



    angular.element(document).ready ()->
      $(".employees-list table").stupidtable()
    
    updateCalendar = ()->
      $http.get('/months/index.json').success (json)-> 
        $scope.areas_months = json
    updateEmpList = ()->
      $scope.employees = Employee.query()

    saveWM = (wmItem, emp_id)->
      start = Math.min(wmItem.from, wmItem.to)
      end = Math.max(wmItem.from, wmItem.to)
      for m in [start..end]
        console.log "workmonth: #{m}, for: #{emp_id}"
        Workmonth.save
          workmonth: 
            month: m
            employee_id: emp_id
          ,
          (wm)-> updateCalendar() if m == end

    $scope.deleteEmployee = (employee, index) -> 
      employee.$delete ->
        $scope.employees.splice(index, 1)
        updateCalendar()

    $scope.editEmployee = (employee) ->
      $scope.newEmployeeMethod = 'update'
      $scope.newEmployee = employee

    $scope.saveNewEmployee = () ->
      $scope.newEmployeeMethod = 'update' if $scope.newEmployeeMethod == 'update'
      
      Employee[$scope.newEmployeeMethod](id: $scope.newEmployee.id, employee: $scope.newEmployee)
      .$promise.then (o)->
        if $scope.newEmployeeMethod == 'save'
          saveWM($scope.newEmployeeWM, o.id)
          $scope.employees.push o
        else
          # e = _.where($scope.employees, {id: o.employee.id})
          # index = $scope.employees.indexOf(e)
          # $scope.employees[index] = o.employee
          updateEmpList()
        updateCalendar()
        $scope.newEmployeeWM = {}

      $scope.newEmployee = {}
      #CLOSE modal
      $("#employeeModal").modal('hide')
      return
    $scope.setTempEmpId = (id) ->
      $scope.current_employee_id = id

    addVacationModel = (wm_start, wm_end, m)->
      Vacation.save
        month: m
        employee_id: $scope.current_employee_id 
        start_vacation: wm_start
        end_vacation: wm_end

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