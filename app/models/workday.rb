class Workday < ActiveRecord::Base
  belongs_to :employee

  delegate :area_id, to: :employee

  def title
    "#{self.employee.name}  [X]"
  end

  def className
    "g#{self.employee.grade}-event"
  end

  def as_json(options = {})
    super({except: [:id]}).merge({title: self.title, 
      className: self.className, area_id: self.area_id, wd_id: self.id})
  end
end
