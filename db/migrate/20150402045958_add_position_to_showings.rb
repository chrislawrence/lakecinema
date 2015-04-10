class AddPositionToShowings < ActiveRecord::Migration
  def change
    add_column :showings, :position, :integer
    remove_column :showings, :view_index
  end
end
