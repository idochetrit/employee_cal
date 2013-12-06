class Workmonth < ActiveRecord::Base


  def self.employees(month)
    Employee.where(id: where(month: month).pluck(:employee_id))  
  end
end
