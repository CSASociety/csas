class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :campaign_id
      t.integer :user_id
      t.boolean :pending, default: true
      t.boolean :active, default: false
      t.boolean :denied, default: false
      t.boolean :removed, default: false
      t.integer :status_approver_id

      t.timestamps
    end
  end
end
