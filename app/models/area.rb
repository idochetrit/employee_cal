class Area < ActiveRecord::Base
  has_many :employees

  def self.areas_by_months
    res = []
    12.times do |month_num|
      res << all.map do |a| 
        emps = Workmonth.employees(month_num+1).select {|e| e.area_id == a.id}
        { area: a, 
          emps: emps,
          hi_emps_count:  emps.select {|e| e.grade == 2}.size,
          md_emps_count:  emps.select {|e| e.grade == 1}.size,
          lw_emps_count:  emps.select {|e| e.grade == 0}.size
        } 
      end
    end
    res
  end
end
