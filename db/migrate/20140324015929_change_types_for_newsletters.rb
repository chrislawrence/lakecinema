class ChangeTypesForNewsletters < ActiveRecord::Migration
  def change
    remove_column :newsletters, :body
    remove_column :newsletters, :introduction
    add_column :newsletters, :body, :text
    add_column :newsletters, :introduction, :text
  end
end
