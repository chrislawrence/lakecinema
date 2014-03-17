class RemoveSentFromNewsletters < ActiveRecord::Migration
  def change
    remove_column :newsletters, :sent, :boolean
  end
end
