class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_many :games
  has_many :charcter_templates
  has_many :resources
  has_many :players
  has_many :campaigns, through: :players
  has_many :status_approver, class_name: 'Player'

  def self.confirmed
    where.not(confirmed_at: nil)
  end
end
