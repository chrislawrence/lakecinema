class ChangeSendTimeOnNewsletters < ActiveRecord::Migration
  def change
    remove_column :newsletters, :send_time
    add_column :newsletters, :send_date, :date
  end
end
