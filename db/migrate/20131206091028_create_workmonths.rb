class CreateWorkmonths < ActiveRecord::Migration
  def change
    create_table :workmonths do |t|
      t.string :name
      t.integer :employeeId
      t.integer :year

      t.timestamps
    end
  end
end
