class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_many :games
  has_many :characters
  has_many :resources
  has_many :players
  has_many :campaigns, through: :players
  has_many :status_approver, class_name: 'Player'
  has_one :profile
  has_many :assistants
  has_many :assisted_campaigns, through: :assistants, source: :campaign


  def self.confirmed
    where.not(confirmed_at: nil)
  end
end
