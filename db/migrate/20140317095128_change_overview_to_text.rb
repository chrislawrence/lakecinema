class ChangeOverviewToText < ActiveRecord::Migration
  def change
    remove_column :movies, :overview
    add_column :movies, :overview, :text
  end
end
