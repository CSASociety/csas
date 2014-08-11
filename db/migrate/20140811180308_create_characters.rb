class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :player
      t.string :name
      t.text :bio
      t.text :gm_bio
      t.string :status
      t.integer :image_id
      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
