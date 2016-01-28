class UpdateEmailColumns < ActiveRecord::Migration
  def change
    rename_column :emails_users, :sent_email_id, :email_id
    rename_column :emails_events, :sent_email_id, :email_id
    rename_column :campaigns_emails, :sent_email_id, :email_id
  end
end
