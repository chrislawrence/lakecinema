class AddViewIndexToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :view_index, :integer
  end
end
