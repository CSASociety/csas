class Character < ActiveRecord::Base
  has_paper_trail
  has_many :attachments, as: :attachable
  has_many :resources, through: :attachments

  belongs_to :image, class_name: "Resource"

   alias_attribute :title, :name

end
