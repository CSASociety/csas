class CreateCampaignCharacters < ActiveRecord::Migration
  def change
    create_table :campaign_characters do |t|
      t.integer :campaign_id
      t.integer :character_id
      t.string :status

      t.timestamps
    end
  end
end
