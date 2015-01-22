class ChangeCharacterBack < ActiveRecord::Migration
  def change
    rename_table :character_templates ,:characters
  end
end
