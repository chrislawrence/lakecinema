class AddSendTimeToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :send_time, :time
  end
end
