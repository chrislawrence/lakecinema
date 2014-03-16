class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.date :start_date
      t.date :end_date
      t.string :title

      t.timestamps
    end
  end
end
