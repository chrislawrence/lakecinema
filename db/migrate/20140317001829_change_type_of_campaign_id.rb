class ChangeTypeOfCampaignId < ActiveRecord::Migration
  def change
    remove_column :newsletters, :campaign_id
    add_column :newsletters, :campaign_id, :string
  end
end
