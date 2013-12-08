class Workmonth < ActiveRecord::Base
  belongs_to :employee

  def self.employees(month)
    Employee.where(id: where(month: month).pluck(:employee_id))  
  end
end
