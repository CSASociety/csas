class Game < ActiveRecord::Base
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments

  belongs_to :image, class_name: "Resource"


end
