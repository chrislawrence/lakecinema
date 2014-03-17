class AddSentToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :sent, :boolean, default: false
  end
end
