class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :rating
      t.string :overview
      t.string :poster_url
      t.string :week_id

      t.timestamps
    end
  end
end
