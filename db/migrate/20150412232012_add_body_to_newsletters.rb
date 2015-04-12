class AddBodyToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :body, :text
  end
end
