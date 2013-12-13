class MonthConcern
  attr_accessor :employees

  def initialize(month)
    @month = month
  end

  def employees(klass = Workmonth)
    @employees ||= Employee.where(id: klass.where(month: @month).pluck(:employee_id))
  end

  def employees_by_area(a)
    employees.select {|e| e.area_id == a.id}
  end

  def workdays
    Workday.where('extract(month from start) = ?', @month)
  end
end