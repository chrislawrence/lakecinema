class RemoveBodyFromNewsletters < ActiveRecord::Migration
  def change
    remove_column :newsletters, :body
  end
end
