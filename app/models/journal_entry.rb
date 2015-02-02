# == Schema Information
#
# Table name: journal_entries
#
#  id                  :integer          not null, primary key
#  content             :text
#  date                :string(255)
#  player_character_id :integer
#  private             :boolean          default(FALSE)
#  created_at          :datetime
#  updated_at          :datetime
#

class JournalEntry < ActiveRecord::Base
  validates_presence_of :content, :date, :player_character
  belongs_to :player_character
end
