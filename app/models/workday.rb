class Workday < ActiveRecord::Base
  belongs_to :employee

  def title
    "#{self.employee.name} - #{self.employee.area.name}"
  end

  def className
    "g#{self.employee.grade}-event"
  end

  def self.months_workdays
    res = []
    (1..12).to_a.each do |month|
      current_month = MonthConcern.new(month)
      res << {workdays: current_month.workdays} 
    end
    res
  end

  # def as_json
  #   super[:start] = super[:start].strptime "%Y/%M/%D"
  # end

  def attributes
    super.merge(title: self.title, className: self.className)
  end
end
