class Employee < ActiveRecord::Base
  belongs_to :area
  has_many :workmonths, dependent: :destroy
  has_many :workdays, dependent: :destroy

  validates :name, :area_id, :grade, presence: true

  default_scope  { order(:grade) }

  def grade_str
    case self.grade
      when 0 then 'Low (> 500)'
      when 1 then 'Medium (500)'
      when 2 then 'High (1000)'
      when 3 then 'Super High (1500)'
    end
  end

  def as_json(options = {})
    super(options).merge(grade_str: self.grade_str, area_name: self.area.name,
      min_month: self.workmonths.minimum(:month), max_month: self.workmonths.maximum(:month))
  end
end
