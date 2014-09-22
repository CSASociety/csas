class AddFieldsToPlayerCharacters < ActiveRecord::Migration
  def change
    add_column :player_characters, :name, :string
    add_column :player_characters, :caste, :string
    add_column :player_characters, :description, :text
    add_column :player_characters, :bio, :text
    add_column :player_characters, :secrets, :text
    add_column :player_characters, :player_id, :integer
    add_column :player_characters, :image_id, :integer
  end
end
