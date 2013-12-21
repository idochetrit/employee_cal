class Vacation
  attr_accessor :month, :employee_id, :start, :end


  def initialize(month, start, endv, employee_id)
    @month = month
    @start = start
    @end = endv
    @employee_id = employee_id
  end
end