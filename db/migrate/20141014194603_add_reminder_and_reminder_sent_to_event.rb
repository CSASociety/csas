class AddReminderAndReminderSentToEvent < ActiveRecord::Migration
  def change
    add_column :events, :reminder, :integer
    add_column :events, :reminder_sent, :boolean
  end
end
