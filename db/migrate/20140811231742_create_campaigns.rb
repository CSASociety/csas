class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :image_id
      t.text :intro
      t.integer :game_id

      t.timestamps
    end
  end
end
