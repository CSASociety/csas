class Game < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments
  belongs_to :user

  has_many :campaigns

  belongs_to :image, class_name: "Resource"

  validates :title, length: { minimum: 3 }
end

