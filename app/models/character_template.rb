class CharacterTemplate < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments
  belongs_to :user

  has_many :player_characters
  has_many :campaigns, through: :player_characters

  belongs_to :image, class_name: "Resource"

  alias_attribute :title, :name

end
