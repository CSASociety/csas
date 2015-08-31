# == Schema Information
#
# Table name: campaigns
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text
#  link               :string(255)
#  image_id           :integer
#  intro              :text
#  game_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  user_id            :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Campaign < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :entity

  has_many :assistants
  has_many :aids, through: :assistants, source: :user
  has_and_belongs_to_many :sent_emails


  belongs_to :gm, foreign_key: :user_id, class_name: :User

  #has_and_belongs_to_many :characters
  has_and_belongs_to_many :events

  has_many :characters
  has_many :player_characters, through: :characters

  has_many :players
  has_many :users, through: :players


  belongs_to :game

  #belongs_to :image, class_name: "Resource"
  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }
  validates_attachment_content_type :image, :content_type => /\Aimage/


  #TODO May be unneded. Check later after applyed.
  def active_players
    players.active
  end

  def adventuring_player_characters()
    player_characters.where(status: "adventuring")
  end


  def user_is_active_player?(user)
    result = false
    self.players.active.each do |player|
      result = true if user.present? && player.user_id == user.id
    end
    result
  end


end
