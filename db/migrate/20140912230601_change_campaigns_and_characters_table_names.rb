class ChangeCampaignsAndCharactersTableNames < ActiveRecord::Migration
  def change
    rename_table :characters, :character_templates
    rename_column :campaign_characters, :character_id, :character_template_id
  end
end
