class AddImagesToGameCampaignAndCharacter < ActiveRecord::Migration
  def change
    add_attachment :games, :image
    add_attachment :campaigns, :image
    add_attachment :characters, :image
  end
end
