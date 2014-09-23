class CampaignsEvents < ActiveRecord::Migration
  def change
    create_table 'campaigns_events', :id => false do |t|
      t.column :campaign_id, :integer
      t.column :event_id, :integer
    end
  end
end
