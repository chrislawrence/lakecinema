class ChangeTypeOfHolidays < ActiveRecord::Migration
  def change
    remove_column :holidays, :preamble
    remove_column :holidays, :body
    add_column :holidays, :preamble, :text
    add_column :holidays, :body, :text
  end
end
