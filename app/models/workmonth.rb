class Workmonth < ActiveRecord::Base


  def employees
    Employee.where(month: self.month)
  end
end
