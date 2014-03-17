class AddSentToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :sent, :boolean
    add_column :newsletters, :default, :false
  end
end
