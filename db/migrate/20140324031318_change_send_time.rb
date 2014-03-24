class ChangeSendTime < ActiveRecord::Migration
  def change
    remove_column :newsletters, :send_time
    add_column :newsletters, :send_time, :datetime
  end
end
