class ExcahngeCharacterAndPlayercharacter < ActiveRecord::Migration
  def change
    rename_table :characters, :temp
    rename_table :player_characters, :characters
    rename_table :temp, :player_characters
    rename_column :characters, :character_id, :player_character_id
  end
end
