# == Schema Information
#
# Table name: campaigns
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  link        :string(255)
#  image_id    :integer
#  intro       :text
#  game_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Campaign < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments

  has_many :assistants
  has_many :aids, through: :assistants, source: :user

  belongs_to :gm, foreign_key: :user_id, class_name: :User

  has_and_belongs_to_many :characters
  has_and_belongs_to_many :events

  has_many :player_characters

  has_many :players
  has_many :users, through: :players


  belongs_to :game

  belongs_to :image, class_name: "Resource"

  #TODO May be unneded. Check later after applyed.
  def active_players
    players.active
  end

  def user_is_active_player?(user)
    result = false
    self.players.active.each do |player|
      result = true if user.present? && player.user_id == user.id
    end
    result
  end


end
