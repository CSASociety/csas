class ExcahngeCharacterAndPlayercharacter < ActiveRecord::Migration
  def change
    rename_table :characters, :temp
    rename_table :player_characters, :characters
    rename_table :temp, :player_characters
  end
end
