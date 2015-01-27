# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  start_at      :datetime
#  stop_at       :datetime
#  group_id      :integer
#  host_id       :integer
#  location      :string(255)
#  latitude      :float
#  longitude     :float
#  created_at    :datetime
#  updated_at    :datetime
#  reminder      :integer
#  reminder_sent :boolean
#

class Event < ActiveRecord::Base
  # has_many Cmapaigns, Chapters, Groups
  # Collect Players Games and Characters based of campaign (with a select to say character are not there)
  #
  has_and_belongs_to_many :campaigns
  geocoded_by :location
  after_validation :geocode, :if => :location_changed?
end
