class ChangeCharacterAgain < ActiveRecord::Migration
  def change
    rename_column :player_characters, :character_template_id, :character_id
  end
end
