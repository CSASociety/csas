class AddCurrentCampaignToCharacters < ActiveRecord::Migration
  def change
    add_reference :characters, :current_campaign, index: true
  end
end
