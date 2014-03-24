class AddZoneToSendTime < ActiveRecord::Migration
  def change
    remove_column :newsletters, :send_time
    add_column :newsletters, :send_time, :timestamptz
  end
end
