class AddPosterProcessingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :poster_processing, :boolean
  end
end
