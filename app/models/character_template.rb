class CharacterTemplate < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments
  belongs_to :user

  has_many :campaign_characters
  has_many :campaigns, through: :campaign_characters

  belongs_to :image, class_name: "Resource"

  alias_attribute :title, :name

end
