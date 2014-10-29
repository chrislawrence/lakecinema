class AddBodyToWeek < ActiveRecord::Migration
  def change
    add_column :weeks, :body, :text
  end
end
