# == Schema Information
#
# Table name: player_characters
#
#  id                    :integer          not null, primary key
#  campaign_id           :integer
#  character_template_id :integer
#  status                :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  name                  :string(255)
#  caste                 :string(255)
#  description           :text
#  bio                   :text
#  secrets               :text
#  player_id             :integer
#  image_id              :integer
#

class PlayerCharacter < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :player
  belongs_to :character
  belongs_to :image, class_name: "Resource"
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments

  has_many :journal_entries

  validates :player, :presence => true
  validates :campaign, :presence => true

  alias_attribute :title, :name

  include AASM

  aasm :column => 'status' do
    state :adventuring, inital: true
    state :retired
    state :dead
    state :missing

    event :join do
      transitions from: [:retired, :dead, :missing], to: :adventuring
    end

    event :retire do
      transitions from: [:adventuring, :missing], to: :retired
    end

    event :kill do
      transitions from: [:adventuring, :missing], to: :dead
    end

    event :lose do
      transitions from: :adventuring, to: :missing
    end

  end
end
