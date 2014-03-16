class IAmDumb < ActiveRecord::Migration
  def change
    remove_column :showings, :order
    add_column :showings, :view_index, :integer, default: 0
  end
end
