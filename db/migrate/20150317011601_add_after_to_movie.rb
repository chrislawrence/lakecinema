class AddAfterToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :after, :text
  end
end
