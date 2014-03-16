class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :preamble
      t.string :body
      t.integer :week_id

      t.timestamps
    end
  end
end
