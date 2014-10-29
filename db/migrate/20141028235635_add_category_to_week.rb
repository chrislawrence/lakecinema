class AddCategoryToWeek < ActiveRecord::Migration
  def change
    add_column :weeks, :category, :string, default: 'standard'
  end
end
