class JournalEntry < ActiveRecord::Base
  validates_presence_of :content, :date, :player_character
  belongs_to :player_character
end
