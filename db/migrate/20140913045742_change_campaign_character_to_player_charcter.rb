class ChangeCampaignCharacterToPlayerCharcter < ActiveRecord::Migration
  def change
    rename_table :campaign_characters, :player_characters
  end
end
