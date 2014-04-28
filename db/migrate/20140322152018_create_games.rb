class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :image_id
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
