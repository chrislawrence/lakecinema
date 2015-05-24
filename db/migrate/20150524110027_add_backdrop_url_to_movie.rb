class AddBackdropUrlToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :backdrop_url, :string
  end
end
