class  Attachment < ActiveRecord::Base

  belongs_to :resource
  belongs_to :attachable, polymorphic: true

  accepts_nested_attributes_for :resource

end
