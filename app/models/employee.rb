class Employee < ActiveRecord::Base
  belongs_to :area

  def grade_str
    case self.grade
      when 0 then 'Low'
      when 1 then 'Medium'
      when 2 then 'High'
    end
  end
end
