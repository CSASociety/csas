class CreateSentEmails < ActiveRecord::Migration
  def change
    create_table :sent_emails do |t|
      t.string :subject
      t.text :body

      t.timestamps
    end

    create_table :sent_emails_users, id: false do |t|
      t.integer :sent_email_id
      t.integer :user_id

      t.timestamps
    end

    create_table :events_sent_emails, id: false do |t|
      t.integer :sent_email_id
      t.integer :event_id

      t.timestamps
    end

    create_table :campaigns_sent_emails, id: false do |t|
      t.integer :sent_email_id
      t.integer :campaign_id

      t.timestamps
    end



  end
end
