class CreateShowings < ActiveRecord::Migration
  def change
    create_table :showings do |t|
      t.string :day
      t.string :times
      t.integer :movie_id

      t.timestamps
    end
  end
end
