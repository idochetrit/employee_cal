module WorkmonthsHelper
  def ten_years_array
    (Date.today.year..10.years.from_now.year).to_a.map { |y| [y,y] }
  end

  def months
    (1..12).to_a.map { |m| [m,m] }
  end
end
