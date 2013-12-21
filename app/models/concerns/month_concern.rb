class MonthConcern
  attr_accessor :employees

  def initialize(month)
    @month = month
  end

  def employees(vac = nil)
    @employees ||= Employee.where(id: Workmonth.vacation(vac).where(month: @month).pluck(:employee_id))
  end

  def employees_by_area(a, vac = nil)
    employees(vac).select {|e| e.area_id == a.id}
  end

  def workdays
    @workdays ||= Workday.where('extract(month from start) = ?', @month)
  end

  def workdays_by_area(a)
    workdays.select {|wd| wd.area_id == a.id}
  end

  def vacations
    Workmonth.vacation(true).where(month: @month).map { |wm| 
      Vacation.new(@month, wm.start_vacation, wm.end_vacation, wm.employee_id)
    }
  end

end