class AddColumnToWorkmonth < ActiveRecord::Migration
  def change
    add_column :workmonths, :vacation, :boolean, default: false
    add_column :workmonths, :start_vacation, :date
    add_column :workmonths, :end_vacation, :date
  end
end
