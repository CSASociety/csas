class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :games
  has_many :charcter_templates
  has_many :resources
  has_many :players
  has_many :campaigns, through: :players
  has_many :status_approver, class_name: 'Player'
end
