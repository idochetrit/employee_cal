class Area < ActiveRecord::Base
  has_many :employees

  def self.areas_by_months
    res = []
    12.times do |month_num|
      res << all.map do |a| 
        {area: a, emps: Workmonth.employees(month_num).select {|e| e.area_id == a.id} } 
      end
    end
    res
  end
end
