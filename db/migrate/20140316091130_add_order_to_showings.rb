class AddOrderToShowings < ActiveRecord::Migration
  def change
    add_column :showings, :order, :integer, default: 0
  end
end
