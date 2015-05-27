class ChangeCastToStringOnMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :cast, :string, array: true
    add_column :movies, :cast, :string
  end
end
