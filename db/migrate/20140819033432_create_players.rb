class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :campaign_id
      t.integer :user_id
      t.string :aasm_state
      t.integer :status_approver_id

      t.timestamps
    end
  end
end
