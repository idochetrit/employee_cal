class CreateWorkdays < ActiveRecord::Migration
  def change
    create_table :workdays do |t|
      t.references :employee, index: true
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
