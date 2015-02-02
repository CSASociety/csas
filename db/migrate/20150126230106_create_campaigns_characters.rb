class CreateCampaignsCharacters < ActiveRecord::Migration
  def change
    create_table :campaigns_characters, id: false do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :character, index: true

      t.timestamp
    end
  end
end
