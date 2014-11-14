class AddCastAndCrewToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :cast, :string, array: true
    add_column :movies, :director, :string
  end
end
