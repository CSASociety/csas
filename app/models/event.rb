class Event < ActiveRecord::Base
  # has_many Cmapaigns, Chapters, Groups
  # Collect Players Games and Characters based of campaign (with a select to say character are not there)
  #
  has_and_belongs_to_many :campaigns
  geocoded_by :location
  after_validation :geocode, :if => :location_changed?
end
