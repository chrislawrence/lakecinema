class ChangeOrderToIndexOnShowings < ActiveRecord::Migration
  def change
    remove_column :showings, :order
    add_column :showings, :order, :integer, default: 0
  end
end
