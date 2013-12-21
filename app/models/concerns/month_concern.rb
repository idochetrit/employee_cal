class MonthConcern
  attr_accessor :employees

  def initialize(month)
    @month = month
  end

  def employees(klass = Workmonth)
    @employees ||= Employee.where(id: klass.vacation(false).where(month: @month).pluck(:employee_id))
  end

  def employees_by_area(a)
    employees.select {|e| e.area_id == a.id}
  end

  def workdays
    @workdays ||= Workday.where('extract(month from start) = ?', @month)
  end


  def workdays_by_area(a)
    workdays.select {|wd| wd.area_id == a.id}
  end
end