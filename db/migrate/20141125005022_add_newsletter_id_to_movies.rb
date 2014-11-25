class AddNewsletterIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :newsletter_id, :integer
  end
end
