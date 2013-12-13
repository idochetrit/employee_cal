class Employee < ActiveRecord::Base
  belongs_to :area
  has_many :workmonths
  has_many :workdays

  def grade_str
    case self.grade
      when 0 then 'Low (> 500)'
      when 1 then 'Medium (500)'
      when 2 then 'High (1000)'
      when 3 then 'Super High (1500)'
    end
  end

  def attributes
    super.merge(grade_str: self.grade_str)
  end
end
