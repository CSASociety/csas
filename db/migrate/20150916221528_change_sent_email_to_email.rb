class ChangeSentEmailToEmail < ActiveRecord::Migration
  def change
    rename_table :sent_emails, :emails
    rename_table :sent_emails_users, :emails_users
    rename_table :events_sent_emails, :emails_events
    rename_table :campaigns_sent_emails, :campaigns_emails
    add_column :emails, :status, :string
    add_column :emails, :schedule_send_date, :date
    add_column :emails, :recipients, :text
  end
end
