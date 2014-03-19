class AddExtraToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :extra, :string
  end
end
