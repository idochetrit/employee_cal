class Area < ActiveRecord::Base
  has_many :employees

  def self.areas_by_months
    res = []
    (1..12).to_a.each do |month_num|
      current_month = MonthConcern.new(month_num)
      res << all.map do |a| 
        emps = current_month.employees_by_area(a)
        { area: a, 
          emps: emps.as_json,
          workdays: current_month.workdays_by_area(a),
          sh_emps_count:  emps.select {|e| e.grade == 3}.size,
          hi_emps_count:  emps.select {|e| e.grade == 2}.size,
          md_emps_count:  emps.select {|e| e.grade == 1}.size,
          lw_emps_count:  emps.select {|e| e.grade == 0}.size
        } 
      end
    end
    res
  end
end
