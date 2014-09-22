class Campaign < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments
  belongs_to :gm, foreign_key: :user_id, class_name: :User

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
