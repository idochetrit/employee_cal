class Workmonth < ActiveRecord::Base
  belongs_to :employee
  before_save :set_default



  scope :no_vacation, ->{ where(vacation: false) }

  def self.employees(month)
    Employee.where(id: where(month: month).pluck(:employee_id))  
  end


  protected

   def set_default
     self.year = Date.today.year unless self.year
   end
end
