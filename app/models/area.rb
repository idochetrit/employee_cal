class Area < ActiveRecord::Base
  has_many :employees

  def self.areas_by_months()
    res = []
    (1..12).to_a.each do |month_num|
      res << areaItem_by_month(month_num)
    end
    res
  end


  def self.areaItem_by_month(month, deep = false)
    current_month = MonthConcern.new(month)
    return { areaItems: all.map do |a| 
      emps = current_month.employees_by_area(a)
      hash = { area: a, 
        sh_emps_count:  emps.select {|e| e.grade == 3}.size,
        hi_emps_count:  emps.select {|e| e.grade == 2}.size,
        md_emps_count:  emps.select {|e| e.grade == 1}.size,
        lw_emps_count:  emps.select {|e| e.grade == 0}.size
      }
      if deep
        hash.merge!({ emps: emps.as_json, workdays: current_month.workdays_by_area(a) })
      end
      hash
    end}
  end

end
